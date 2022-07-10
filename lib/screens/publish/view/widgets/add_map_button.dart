import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../screens.dart';

class AddMapButton extends StatelessWidget {
  const AddMapButton({Key? key}) : super(key: key);

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
        const GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(27, 29),
            zoom: 3.0,
          ),
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, MapScreen.routeName);
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
