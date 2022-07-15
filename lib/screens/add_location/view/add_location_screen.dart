import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../../../core/map_utils.dart' as map_utils;
import '../../autofill/view/autofill_screen.dart';

class AddLocationScreen extends StatefulWidget {
  static const routeName = '/add_location';
  final LatLng? initialPosition;
  const AddLocationScreen({
    this.initialPosition,
    Key? key,
  }) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _controller = Completer<GoogleMapController>();
  LatLng? _position;

  static const _initalCamera = CameraPosition(
    target: map_utils.egyptCenter,
    zoom: 3.0,
  );

  @override
  void initState() {
    super.initState();
    map_utils.checkPermission();
    if (widget.initialPosition != null) {
      _position = widget.initialPosition!;
    } else {
      _moveCameraToCurrentLocation();
    }
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
        title: const Text('rental_location').tr(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await Navigator.of(context).pushNamed(
                AutofillScreen.routeName,
              ) as StructuredFormatting?;

              if (result != null) {
                final coordinates = await _getLatLngFromLocation(result);
                await _animateToPosition(coordinates);
                setState(() => _position = coordinates);
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: widget.initialPosition != null
            ? CameraPosition(
                target: widget.initialPosition!,
                zoom: 18,
              )
            : _initalCamera,
        zoomControlsEnabled: false,
        compassEnabled: false,
        myLocationEnabled: true,
        markers: {
          if (_position != null)
            Marker(
              markerId: const MarkerId('2'),
              position: _position!,
              draggable: true,
              onDrag: (latlng) => setState(() => _position = latlng),
            )
        },
        onLongPress: (latlng) {
          setState(() => _position = latlng);
        },
        myLocationButtonEnabled: false,
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: map_utils.egyptSouthwest,
            northeast: map_utils.egyptNortheast,
          ),
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'location',
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.gps_fixed,
              color: Colors.blueGrey,
            ),
            onPressed: () async {
              await _moveCameraToCurrentLocation();
            },
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            heroTag: 'submit',
            child: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(_position);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _animateToPosition(LatLng coordinates) async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: coordinates,
        zoom: 18,
      )),
    );
  }

  Future<LatLng> _getLatLngFromLocation(StructuredFormatting result) async {
    final p = (await locationFromAddress(
      '${result.mainText ?? ''} ${result.secondaryText ?? ''}',
    ))
        .first;

    return map_utils.getLatLngfrom(p);
  }

  Future<void> _moveCameraToCurrentLocation() async {
    final p = await map_utils.currentLocation();
    await _animateToPosition(p);
  }
}
