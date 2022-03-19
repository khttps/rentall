import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../enums/enums.dart';
import '../models/models.dart';

abstract class RentalRepository {
  Stream<List<Rental>> getRentals({
    PropertyType? propertyType,
    RentType? rentType,
    int? governorateId,
    int? regionId,
  });
  Future<void> addRental(Rental rentall);
}

class RentalRepositoryImpl implements RentalRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  RentalRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Stream<List<Rental>> getRentals({
    PropertyType? propertyType,
    RentType? rentType,
    int? governorateId,
    int? regionId,
  }) {
    return _firestore
        .collection('rentals')
        .where('publishStatus', isEqualTo: PublishStatus.approved.index)
        .where('propertyType', isEqualTo: propertyType?.index)
        .where('rentType', isEqualTo: rentType?.index)
        .where('governorateId', isEqualTo: governorateId)
        .where('regionId', isEqualTo: regionId)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return Rental.fromSnapshot(doc);
          },
        ).toList();
      },
    );
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
      print((err as dynamic).message);
    }

    await _firestore.collection('rentals').add(Rental.toMap(rental));
  }
}
