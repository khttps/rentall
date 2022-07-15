import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPreview extends StatelessWidget {
  final GeoPoint position;
  const MapPreview({required this.position, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final latlng = LatLng(position.latitude, position.longitude);
    return Container(
      height: 150.0,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
          )
        ],
        color: Colors.grey,
      ),
      child: Stack(
        children: [
          GoogleMap(
            onTap: (_) async {
              final url = _createUrl(position);
              await _launchMaps(url);
            },
            initialCameraPosition: CameraPosition(
              target: latlng,
              zoom: 18,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('1'),
                position: latlng,
              )
            },
            compassEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            mapType: MapType.normal,
          ),
        ],
      ),
    );
  }

  Uri _createUrl(GeoPoint p) {
    Uri uri;
    if (Platform.isAndroid) {
      final query = '${p.latitude},${p.longitude}';

      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      final params = {'ll': '${p.latitude},${p.longitude}'};
      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '${p.latitude},${p.longitude}'});
    }
    return uri;
  }

  Future<void> _launchMaps(Uri uri) async {
    await launchUrl(uri);
  }
}
