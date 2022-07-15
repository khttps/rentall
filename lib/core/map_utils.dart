import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  const MapUtils._();

  static const egyptSouthwest = LatLng(20.000109, 22.003512);
  static const egyptNortheast = LatLng(33.600013, 35.221769);
  static const egyptCenter = LatLng(27, 29);

  static Future<void> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
  }

  static getLatLngfrom(dynamic p) {
    return LatLng(p.latitude, p.longitude);
  }

  static Future<LatLng> currentLocation() async {
    final p = await Geolocator.getCurrentPosition();
    return getLatLngfrom(p);
  }
}
