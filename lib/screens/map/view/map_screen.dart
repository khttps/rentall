import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _apiKey = 'AIzaSyBhx6ri_9UQuGXNQDeSsalYau0YIuk0XNo';
  final _places = GooglePlace(_apiKey);

  final _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
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
            onPressed: () async {},
          ),
        ],
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(27, 29),
          zoom: 5.0,
        ),
        zoomControlsEnabled: false,
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.gps_fixed),
        onPressed: () async {},
      ),
    );
  }

  // Future<Prediction?> _getPrediction(BuildContext context) {
  //   return PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: _apiKey,
  //     components: [Component(Component.country, 'eg')],
  //     types: [],
  //     strictbounds: false,
  //     decoration: const InputDecoration(
  //       prefixIcon: Icon(Icons.search),
  //     ),
  //   );
  // }

  // Future<void> _displayPrediction(Prediction? prediction) async {
  //   if (prediction != null && prediction.placeId != null) {
  //     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
  //       prediction.placeId!,
  //     );

  //     double lat = detail.result.geometry!.location.lat;
  //     double lng = detail.result.geometry!.location.lng;

  //     final controller = await _controller.future;
  //     controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(
  //             lat,
  //             lng,
  //           ),
  //           zoom: 14,
  //         ),
  //       ),
  //     );
  //   }
  // }
}
