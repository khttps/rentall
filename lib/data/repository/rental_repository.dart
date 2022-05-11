import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rentall/data/model/property_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/governorate.dart';
import '../model/rent_period.dart';
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

    final query = _firestore
        .collection('rentals')
        .where('publishStatus', isEqualTo: PublishStatus.approved.name)
        .where(
          'propertyType',
          isEqualTo: (filters['propertyType'] as PropertyType?)?.value,
        )
        .where(
          'governorate',
          isEqualTo: (filters['governorate'] as Governorate?)?.value,
        )
        .where(
          'rentPeriod',
          isEqualTo: (filters['rentPeriod'] as RentPeriod?)?.value,
        )
        .where('region', isEqualTo: filters['region'])
        .where(
          'price',
          isGreaterThanOrEqualTo: filters['priceFrom'],
          isLessThanOrEqualTo: filters['priceTo'],
        )
        .orderBy('price', descending: true)
        .orderBy('createdAt', descending: true);

    return (await query.get())
        .docs
        .map((doc) => Rental.fromJson(doc.data()))
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

    final map = (await ref.get()).data();
    throwIf(map == null, Exception('Failed to retrieve rental.'));
    return Rental.fromJson(map!);
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

    final map = (await doc.get()).data();
    throwIf(map == null, Exception('Failed to update rental.'));
    return Rental.fromJson(map!);
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
