import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentall/data/models/models.dart';
import 'package:rentall/screens/blocs.dart';
import 'package:rentall/widgets/error_snackbar.dart';
import 'package:rentall/widgets/loading_widget.dart';

import '../../../core/map_utils.dart' as map_utils;
import '../../screens.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _controller = Completer<GoogleMapController>();
  var _mapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    map_utils.checkPermission();
    _moveCameraToCurrentLocation(zoom: 8.0);
  }

  @override
  void dispose() {
    _controller.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('map').tr(),
        ),
        body: BlocConsumer<RentalsBloc, RentalsState>(
          listener: (context, state) {
            if (state.status == RentalsLoadStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(message: tr('map_error')),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                FutureBuilder<List<BitmapDescriptor>>(
                    initialData: const [],
                    future: _getIcons(),
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const LoadingWidget();
                      }
                      return GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(27, 29),
                          zoom: 6,
                        ),
                        zoomControlsEnabled: false,
                        mapType: _mapType,
                        compassEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        cameraTargetBounds: CameraTargetBounds(
                          LatLngBounds(
                            southwest: const LatLng(20.000109, 22.003512),
                            northeast: const LatLng(33.600013, 35.221769),
                          ),
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: state.rentals
                                ?.where((r) => r.location != null)
                                .map(
                                  (r) => Marker(
                                    markerId: MarkerId(r.id!),
                                    position: LatLng(
                                      r.location!.latitude,
                                      r.location!.longitude,
                                    ),
                                    infoWindow: InfoWindow(
                                      title: r.title,
                                      snippet:
                                          '${r.price}EGP/${tr('rentPeriod.${r.rentPeriod!.index}')}',
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          DetailsScreen.routeName,
                                          arguments: r,
                                        );
                                      },
                                    ),
                                    icon: snap.data![r.propertyType!.index - 1],
                                  ),
                                )
                                .toSet() ??
                            {},
                      );
                    }),
                if (state.status == RentalsLoadStatus.loading)
                  const LoadingWidget()
              ],
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              heroTag: 'type',
              backgroundColor: Colors.white,
              child: const Icon(Icons.map, color: Colors.blueGrey),
              onPressed: () {
                setState(() {
                  if (_mapType == MapType.normal) {
                    _mapType = MapType.hybrid;
                  } else {
                    _mapType = MapType.normal;
                  }
                });
              },
            ),
            const SizedBox(height: 8.0),
            FloatingActionButton(
              heroTag: 'current',
              child: const Icon(Icons.gps_fixed),
              onPressed: () async {
                await _moveCameraToCurrentLocation();
              },
            ),
          ],
        ));
  }

  Future<List<BitmapDescriptor>> _getIcons() async {
    final markers = PropertyType.values
        .map((e) => e.markerRes)
        .where((e) => e != null)
        .toList();

    final icons = <BitmapDescriptor>[];

    for (int i = 0; i < markers.length; i++) {
      final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(24.0, 24.0),
        ),
        markers[i]!,
      );
      icons.add(icon);
    }

    return icons;
  }

  Future<void> _moveCameraToCurrentLocation({double? zoom}) async {
    final current = await map_utils.currentLocation();
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: current,
          zoom: zoom ?? 16.0,
        ),
      ),
    );
  }
}
