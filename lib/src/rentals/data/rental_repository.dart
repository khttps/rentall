import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentall/src/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rental.dart';

abstract class RentalRepository {
  // Stream<List<Rental>> watchRentals({
  //   RentalType? propertyType,
  //   RentType? rentType,
  //   int? governorateId,
  //   int? regionId,
  //   int? priceFrom,
  //   int? priceTo,
  // });
  Future<List<Rental>> getRentals({
    RentalType? propertyType,
    RentType? rentType,
    int? governorateId,
    int? regionId,
    int? priceFrom,
    int? priceTo,
  });
  Future<void> addRental(Rental rental);
}

class RentalRepositoryImpl implements RentalRepository {
  final SharedPreferences _prefs;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  RentalRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    required SharedPreferences prefs,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance,
        _prefs = prefs;

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
  Future<List<Rental>> getRentals({
    RentalType? propertyType,
    RentType? rentType,
    int? governorateId,
    int? regionId,
    int? priceFrom,
    int? priceTo,
  }) async {
    return (await _firestore
            .collection('rentals')
            .where('publishStatus', isEqualTo: PublishStatus.approved.index)
            .where('propertyType', isEqualTo: propertyType?.index)
            .where('rentType', isEqualTo: rentType?.index)
            .where('governorateId', isEqualTo: governorateId)
            .where('regionId', isEqualTo: regionId)
            .where(
              'rentPrice',
              isGreaterThanOrEqualTo: priceFrom,
              isLessThanOrEqualTo: priceTo,
            )
            .get())
        .docs
        .map((doc) => Rental.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<void> addRental(Rental rental) async {
    try {
      for (var f in rental.imageFiles!) {
        if (f != null) {
          final url = await (await _storage
                  .ref('ads/${rental.createdAt?.millisecondsSinceEpoch}')
                  .putFile(f))
              .ref
              .getDownloadURL();
          rental.images.add(url);
        }
      }
    } on FirebaseException catch (err) {
      throw Exception(err);
    }

    await _firestore.collection('rentals').add(Rental.toMap(rental));
  }
}
