import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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

  LatLng? _position;

  @override
  void initState() {
    super.initState();

    if (widget.initialPosition != null) {
      _position = LatLng(
        widget.initialPosition!.latitude,
        widget.initialPosition!.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
          )
        ],
      ),
      child: Stack(children: [
        GoogleMap(
          initialCameraPosition: _position != null
              ? CameraPosition(
                  target: _position!,
                  zoom: 18,
                )
              : _initialCamera,
          markers: {
            if (_position != null)
              Marker(
                markerId: const MarkerId('1'),
                position: _position!,
              )
          },
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
              final position = await Navigator.of(context).pushNamed(
                AddLocationScreen.routeName,
                arguments: _position,
              ) as LatLng?;

              if (position != null) {
                final controller = await _controller.future;
                controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: position,
                      zoom: 18,
                    ),
                  ),
                );
                setState(() => _position = position);
                widget.onLocationChanged(_position);
              }
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.black54),
              backgroundColor: Colors.white,
            ),
            child: const Text('add_location').tr(),
          ),
        )
      ]),
    );
  }
}
