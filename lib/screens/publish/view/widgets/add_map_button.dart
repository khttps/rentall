import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../screens.dart';

class AddMapButton extends StatefulWidget {
  final GeoPoint? initialPosition;
  final Function(LatLng?) onLocationChanged;
  const AddMapButton({
    this.initialPosition,
    required this.onLocationChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<AddMapButton> createState() => _AddMapButtonState();
}

class _AddMapButtonState extends State<AddMapButton> {
  final _controller = Completer<GoogleMapController>();

  static const _initialCamera = CameraPosition(
    target: LatLng(27, 29),
    zoom: 3.0,
  );

  LatLng? _initialPosition;

  var _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    if (widget.initialPosition != null) {
      _initialPosition = LatLng(
        widget.initialPosition!.latitude,
        widget.initialPosition!.longitude,
      );

      _markers = [
        Marker(
          markerId: const MarkerId('1'),
          position: _initialPosition!,
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey,
      ),
      child: Stack(children: [
        GoogleMap(
          initialCameraPosition: _initialPosition != null
              ? CameraPosition(
                  target: _initialPosition!,
                  zoom: 18,
                )
              : _initialCamera,
          markers: _markers.toSet(),
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () async {
              final marker = await Navigator.of(context).pushNamed(
                AddLocationScreen.routeName,
                arguments: _initialPosition,
              ) as Marker?;

              if (marker != null) {
                final controller = await _controller.future;
                controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: marker.position,
                      zoom: 18,
                    ),
                  ),
                );
                setState(() {
                  _markers = [marker];
                });
                widget.onLocationChanged(marker.position);
              }
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.black54),
              onSurface: Colors.blueGrey,
              backgroundColor: Colors.white,
            ),
            child: const Text('Add Location'),
          ),
        )
      ]),
    );
  }
}
