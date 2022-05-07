import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rentall/data/model/property_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/governorate.dart';
import '../model/rental.dart';

abstract class RentalRepository {
  Future<List<Rental>> getRentals(Map<String, dynamic> filters);
  Future<Rental> addRental(
    Map<String, dynamic> rental,
    List<File?> images,
  );
  Future<Rental> updateRental(
    String id,
    Map<String, dynamic> rental,
    List<File?>? images,
  );
  Future<void> deleteRental(String id);
}

class RentalRepositoryImpl implements RentalRepository {
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
        _connectionChecker = connectionChecker;

  @override
  Future<List<Rental>> getRentals(Map<String, dynamic> filters) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    return (await _firestore
            .collection('rentals')
            .where('publishStatus', isEqualTo: PublishStatus.approved.index)
            .where(
              'propertyType',
              isEqualTo: (filters['propertyType'] as PropertyType?)?.value,
            )
            .where(
              'governorateId',
              isEqualTo: (filters['governorate'] as Governorate?)?.value,
            )
            // .where(
            //   'rentType',
            //   isEqualTo: (filters['rentType'] as RentType?)?.value,
            // )
            // .where('regionId', isEqualTo: filters['regionId'])
            // .where(
            //   'rentPrice',
            //   isGreaterThanOrEqualTo: filters['priceFrom'],
            //   isLessThanOrEqualTo: filters['priceTo'],
            // )
            // .orderBy('createdAt', descending: true)
            .get())
        .docs
        .map((doc) => Rental.fromSnapshot(doc.data()))
        .toList();
  }

  @override
  Future<Rental> addRental(
    Map<String, dynamic> rental,
    List<File?> imageFiles,
  ) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final imageUrls = <String>[];
    final ref = await _firestore.collection('rentals').add(rental);

    for (var f in imageFiles) {
      if (f != null) {
        final url =
            await (await _storage.ref('${ref.id}/${f.hashCode}.png').putFile(f))
                .ref
                .getDownloadURL();
        imageUrls.add(url);
      }
    }

    await ref.update({'id': ref.id, 'images': imageUrls});
    return Rental.fromSnapshot((await ref.get()).data());

    // return (await _firestore.collection('rentals').doc(rental['id']).get())
    //     .data();
  }

  @override
  Future<Rental> updateRental(
    String id,
    Map<String, dynamic> rental,
    List<File?>? imageFiles,
  ) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }

    // final imageUrls = rental['images'] as List<String>;
    final imageUrls = <String>[];

    if (imageFiles != null) {
      for (var f in imageFiles) {
        if (f != null) {
          final url = await (await _storage
                  .ref('${rental['id']}/${f.hashCode}.png')
                  .putFile(f))
              .ref
              .getDownloadURL();
          imageUrls.add(url);
        }
      }
    }

    final doc = _firestore.collection('rentals').doc(id);
    await doc.update({
      'images': [
        ...(await doc.get()).get('images'),
        ...imageUrls,
      ],
      ...rental,
    });

    return Rental.fromSnapshot((await doc.get()).data());

    // return (await _firestore.collection('rentals').doc(rental.id).get()).data();
  }

  @override
  Future<void> deleteRental(String id) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    await _firestore.collection('rentals').doc(id).delete();
    await _storage.ref('$id/').listAll().then(
          (value) => value.items.forEach((element) async {
            await _storage.ref(element.fullPath).delete();
          }),
        );
  }
}
