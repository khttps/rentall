import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentall/data/model/rental.dart';

void main() {
  group('Rental.fromMap group', () {
    test('All fields test', () {
      final map = {
        'title': 'Hello',
        'images': [],
        'description': 'Description',
        'address': 'Address',
        'location': const GeoPoint(0, 0),
        'floorNumber': 1,
        'numberOfRooms': 1,
        'numberOfBathrooms': 1,
        'furnished': true,
        'area': 100,
        'governorateId': 1,
        'regionId': 1,
        'rentPrice': 500,
        'hostPhoneNumber': '0156516',
        'createdAt': Timestamp(0, 0),
        'rentType': 1,
        'propertyType': 1
      };

      final Rental? rental = Rental.fromJson(map);
      expect(rental, isNotNull);
    });

    test('Exclude enums test', () {
      final map = {
        'title': 'Hello',
        'images': [],
        'description': 'Description',
        'address': 'Address',
        'location': const GeoPoint(0, 0),
        'floorNumber': 1,
        'numberOfRooms': 1,
        'numberOfBathrooms': 1,
        'furnished': true,
        'area': 100,
        'governorateId': 1,
        'regionId': 1,
        'rentPrice': 500,
        'hostPhoneNumber': '0156516',
        'createdAt': Timestamp(0, 0),
      };

      final Rental? rental = Rental.fromJson(map);
      expect(rental, isNotNull);
    });

    test('Required fields only test', () {
      final map = {
        'title': 'Hello',
        'images': [],
        'address': 'Address',
        'governorateId': 1,
        'rentPrice': 500,
        'rentType': 1,
        'propertyType': 1,
        'hostPhoneNumber': 'dadasdad'
      };

      final Rental? rental = Rental.fromJson(map);
      expect(rental, isNotNull);
    });
  });
}
