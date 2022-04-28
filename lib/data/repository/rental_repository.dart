import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rentall/data/model/property_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/governorate.dart';
import '../model/rental.dart';

abstract class RentalRepository {
  // Stream<List<Rental>> watchRentals({
  //   RentalType? propertyType,
  //   RentType? rentType,
  //   int? governorateId,
  //   int? regionId,
  //   int? priceFrom,
  //   int? priceTo,
  // });
  // Future<List<Rental>> getRentals({
  //   PropertyType? propertyType,
  //   RentType? rentType,
  //   int? governorateId,
  //   int? regionId,
  //   int? priceFrom,
  //   int? priceTo,
  // });
  Future<List<Rental>> getRentals(Map<String, dynamic> filters);
  Future<void> addRental(Rental rental, List<File?> images);
}

class RentalRepositoryImpl implements RentalRepository {
  final SharedPreferences _prefs;
  final InternetConnectionChecker _connectionChecker;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  RentalRepositoryImpl(
      {FirebaseFirestore? firestore,
      FirebaseStorage? storage,
      required SharedPreferences prefs,
      required InternetConnectionChecker connectionChecker})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance,
        _prefs = prefs,
        _connectionChecker = connectionChecker;

  // @override
  // Stream<List<Rental>> watchRentals({
  //   RentalType? propertyType,
  //   RentType? rentType,
  //   int? governorateId,
  //   int? regionId,
  //   int? priceFrom,
  //   int? priceTo,
  // }) {
  //   return _firestore
  //       .collection('rentals')
  //       .where('publishStatus', isEqualTo: PublishStatus.approved.index)
  //       .where('propertyType', isEqualTo: propertyType?.index)
  //       .where('rentType', isEqualTo: rentType?.index)
  //       .where('governorateId', isEqualTo: governorateId)
  //       .where('regionId', isEqualTo: regionId)
  //       .where(
  //         'rentPrice',
  //         isGreaterThanOrEqualTo: priceFrom,
  //         isLessThanOrEqualTo: priceTo,
  //       )
  //       .snapshots()
  //       .map(
  //     (snapshot) {
  //       return snapshot.docs.map(
  //         (doc) {
  //           print(doc.data());
  //           return Rental.fromSnapshot(doc);
  //         },
  //       ).toList();
  //     },
  //   );
  // }

  @override
  Future<List<Rental>> getRentals(Map<String, dynamic> filters) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    return (await _firestore
            .collection('rentals')
            .where('publishStatus', isEqualTo: 2)
            .where(
              'propertyType',
              isEqualTo: (filters['propertyType'] as PropertyType?)?.value,
            )
            .where(
              'governorateId',
              isEqualTo: (filters['governorate'] as Governorate?)?.value,
            )
            //.where('rentType', isEqualTo: rentType?.index)
            //.where('regionId', isEqualTo: regionId)
            //.where(
            //  'rentPrice',
            //  isGreaterThanOrEqualTo: priceFrom,
            //  isLessThanOrEqualTo: priceTo,
            //)
            .get())
        .docs
        .map((doc) => Rental.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<void> addRental(Rental rental, List<File?> images) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    for (var f in images) {
      if (f != null) {
        final url = await (await _storage.ref('ads/img.png').putFile(f))
            .ref
            .getDownloadURL();
        rental.images.add(url);
      }
    }

    await _firestore.collection('rentals').add(Rental.toMap(rental));
  }
}
