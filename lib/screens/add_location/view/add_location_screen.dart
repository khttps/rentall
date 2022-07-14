import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

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
    target: LatLng(27, 29),
    zoom: 3.0,
  );

  @override
  void initState() {
    super.initState();
    _checkPermission();
    if (widget.initialPosition != null) {
      _position = widget.initialPosition!;
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
          title: const Text('Rental Location'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                final result = await Navigator.of(context).pushNamed(
                  AutofillScreen.routeName,
                ) as StructuredFormatting?;

                if (result != null) {
                  final coordinates = await _getLatLng(result);
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
                onDrag: (latlng) => setState(() {
                  _position = latlng;
                }),
              )
          },
          onLongPress: (latlng) {
            setState(() => _position = latlng);
          },
          myLocationButtonEnabled: false,
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
                await _getCurrentLocation();
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
        ));
  }

  Future<void> _animateToPosition(LatLng coordinates) async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: coordinates,
          zoom: 18,
        ),
      ),
    );
  }

  Future<LatLng> _getLatLng(StructuredFormatting result) async {
    final coord = (await locationFromAddress(
      '${result.mainText ?? ''} ${result.secondaryText ?? ''}',
    ))
        .first;

    return LatLng(coord.latitude, coord.longitude);
  }

  void _checkPermission() async {
    await Geolocator.checkPermission();
  }

  Future<void> _getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    final p = await Geolocator.getCurrentPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(p.latitude, p.longitude),
        zoom: 18.0,
      ),
    ));
  }
}
