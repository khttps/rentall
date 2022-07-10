import 'dart:io';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

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
  Future<void> archiveRental(String id);
  Future<List<Rental>> getSearchResults(String keyword);
  Future<void> setFavorited(Rental rental);
  Future<void> removeFavorited(Rental rental);
  Future<List<Rental>> getFavourites();
}

class RentalRepositoryImpl implements RentalRepository {
  final InternetConnectionChecker _connectionChecker;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _storage;
  final Algolia _aloglia;

  RentalRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
    FirebaseStorage? storage,
    required SharedPreferences prefs,
    required InternetConnectionChecker connectionChecker,
    required Algolia algolia,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _storage = storage ?? FirebaseStorage.instance,
        _connectionChecker = connectionChecker,
        _aloglia = algolia;

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
    final uid = _firebaseAuth.currentUser!.uid;
    final imageUrls = <String>[];
    final ref = await _firestore.collection('rentals').add({
      ...rental,
      'createdAt': Timestamp.now(),
      'userId': uid,
    });

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

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('rentals')
        .doc(ref.id)
        .set(map!);

    return Rental.fromJson(map);
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
    final updates = {
      'images': [
        ...(await doc.get()).get('images'),
        ...imageUrls,
      ],
      ...rental,
    };

    await doc.update(updates);
    final uid = _firebaseAuth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('rentals')
        .doc(id)
        .update(updates);

    final map = (await doc.get()).data();
    throwIf(map == null, Exception('Failed to update rental.'));
    return Rental.fromJson(map!);
  }

  @override
  Future<void> archiveRental(String id) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    await _firestore
        .collection('rentals')
        .doc(id)
        .update({'publishStatus': PublishStatus.archived.name});

    final uid = _firebaseAuth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('rentals')
        .doc(id)
        .update({'publishStatus': PublishStatus.archived.name});
  }

  @override
  Future<List<Rental>> getSearchResults(String keyword) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final snap =
        await _aloglia.instance.index('rentals').query(keyword).getObjects();

    return (snap.toMap()['hits'] as List)
        .map(
          (e) => Rental.fromJson(e
            ..['createdAt'] = Timestamp.fromMillisecondsSinceEpoch(
              e['createdAt'],
            )),
        )
        .toList();
  }

  @override
  Future<void> setFavorited(Rental rental) async {
    final user = _firebaseAuth.currentUser;
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .doc(rental.id)
        .set(rental.toJson());
  }

  @override
  Future<void> removeFavorited(Rental rental) async {
    final user = _firebaseAuth.currentUser;

    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .doc(rental.id)
        .delete();
  }

  @override
  Future<List<Rental>> getFavourites() async {
    final uid = _firebaseAuth.currentUser!.uid;
    final snap = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();
    return snap.docs.map((doc) => Rental.fromJson(doc.data())).toList();
  }
}
