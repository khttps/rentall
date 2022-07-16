import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/alert.dart';

abstract class AlertRepository {
  Future<String> addAlert(Alert alert);
  Future<List<Alert>> getAlerts();
  Future<void> removeAlert(String id);
  Future<void> updateAlert(String id, Alert alert);
  Future<Alert?> getAlert(String id);
}

class AlertRepositoryImpl implements AlertRepository {
  final InternetConnectionChecker _connectionChecker;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AlertRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
    required InternetConnectionChecker connectionChecker,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _connectionChecker = connectionChecker;

  @override
  Future<String> addAlert(Alert alert) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final user = _firebaseAuth.currentUser;
    final result = await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('alerts')
        .add({
      ...alert.toJson(),
      'createdAt': Timestamp.now(),
    });
    await result.update({'id': result.id});
    return result.id;
  }

  @override
  Future<void> updateAlert(
    String id,
    Alert alert,
  ) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final user = _firebaseAuth.currentUser;
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('alerts')
        .doc(id)
        .update(alert.toJson());
  }

  @override
  Future<List<Alert>> getAlerts() async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final user = _firebaseAuth.currentUser;
    final query = _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('alerts')
        .orderBy('createdAt');

    return (await query.get())
        .docs
        .map((doc) => Alert.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> removeAlert(String id) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final user = _firebaseAuth.currentUser;
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('alerts')
        .doc(id)
        .delete();
  }

  @override
  Future<Alert?> getAlert(String id) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final user = _firebaseAuth.currentUser;
    final snap = await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('alerts')
        .doc(id)
        .get();

    final data = snap.data();

    if (data != null) {
      return Alert.fromJson(data);
    }
    return null;
  }
}
