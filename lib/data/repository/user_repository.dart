import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/models.dart';

abstract class UserRepository {
  Future<auth.User?> signInEmailAndPassword(
    String email,
    String password,
  );
  Future<auth.User?> signUpWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> sendForgotPasswordEmail(String email);
  Future<void> signOut();
  Future<auth.User?> signInWithGoogle();
  Future<auth.User?> signInWithFacebook();
  Future<bool> changeEmailAddress(String newEmail, String currentPassword);
  Future<bool> changePassword(String currentPassword, String newPassword);
  bool get isSignedIn;
  auth.User? get currentUser;
  Stream<auth.User?> get userChanges;
  Future<User?> getUserFromCollection({String? id});
  Stream<User?> watchUserFromCollection();
  Future<void> reloadUser();
  bool isOwned(String userId);
  Future<bool> isFavorited(String id);
  Future<void> updateHost(Map<String, dynamic> host, File? image);
  Future<void> sendVerificationEmail();
  Future<void> verifyPhoneNumber(String phone);
  Future<void> checkEmailVerification();
}

class UserRepositoryImpl implements UserRepository {
  final auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final InternetConnectionChecker _connectionChecker;
  final FirebaseStorage _storage;
  UserRepositoryImpl({
    auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
    FirebaseStorage? firebaseStorage,
    required InternetConnectionChecker connectionChecker,
  })  : _auth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _storage = firebaseStorage ?? FirebaseStorage.instance,
        _connectionChecker = connectionChecker;

  @override
  Future<auth.User?> signInEmailAndPassword(
    String email,
    String password,
  ) async {
    final auth = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user;
  }

  @override
  Future<void> signOut() async {
    final googleSignedIn = await GoogleSignIn().isSignedIn();
    if (googleSignedIn) await GoogleSignIn().signOut();

    final facebookToken = await FacebookAuth.instance.accessToken;
    if (facebookToken != null) {
      await FacebookAuth.instance.logOut();
    }
    await _auth.signOut();
  }

  @override
  bool get isSignedIn => _auth.currentUser != null;

  @override
  auth.User? get currentUser => _auth.currentUser;

  @override
  Future<auth.User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final auth = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (auth.user != null) {
      _firestore.collection('users').doc(auth.user!.uid).set({
        'uid': auth.user!.uid,
        'email': auth.user!.email,
        'verified': auth.user!.emailVerified,
      });

      await _auth.currentUser!.sendEmailVerification();
    }

    return auth.user;
  }

  @override
  Future<void> sendForgotPasswordEmail(String email) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<auth.User?> signInWithGoogle() async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    late final auth.OAuthCredential credential;
    try {
      credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    } catch (err) {
      return null;
    }

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).get().then(
        (doc) {
          if (!doc.exists) {
            doc.reference.set({
              'uid': user.uid,
              'displayName': user.displayName,
              'email': user.email,
              'verified': true,
            });
          }
        },
      );
    }

    return user;
  }

  @override
  Future<auth.User?> signInWithFacebook() async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) return null;

    final facebookAuthCredential = auth.FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );

    final credential = await _auth.signInWithCredential(
      facebookAuthCredential,
    );

    final user = credential.user;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).get().then(
        (doc) {
          if (!doc.exists) {
            doc.reference.set({
              'uid': user.uid,
              'displayName': user.displayName,
              'email': user.email,
              'verified': true,
            });
          }
        },
      );
    }

    return user;
  }

  @override
  Future<bool> changeEmailAddress(
    String newEmail,
    String currentPassword,
  ) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    bool success = false;

    final user = _auth.currentUser;
    final credential = auth.EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );

    final newCredential = await user.reauthenticateWithCredential(credential);
    final newUser = newCredential.user;

    if (newUser != null) {
      await newCredential.user!.updateEmail(newEmail);
      success = true;
    }

    await _firestore.collection('users').doc(user.uid).get().then(
      (doc) {
        doc.reference.update({'email': user.email});
      },
    );

    return success;
  }

  @override
  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }
    bool success = false;

    final user = _auth.currentUser;
    final credential = auth.EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );

    final newCredential = await user.reauthenticateWithCredential(credential);
    final newUser = newCredential.user;

    if (newUser != null) {
      await newCredential.user!.updatePassword(newPassword);
      success = true;
    }
    return success;
  }

  @override
  Stream<auth.User?> get userChanges => _auth.userChanges();

  @override
  Future<bool> isFavorited(String id) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }

    final user = _auth.currentUser;
    if (user == null) return false;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(id)
        .get();
    return doc.exists;
  }

  @override
  bool isOwned(String userId) {
    final user = _auth.currentUser;
    if (user == null) return false;
    return user.uid == userId;
  }

  @override
  Future<void> updateHost(Map<String, dynamic> host, File? image) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }

    final userId = currentUser?.uid;

    throwIf(userId == null, 'Couldn\'t retrieve user info.');

    String? url;
    if (image != null) {
      url = await (await _storage
              .ref('$userId/${image.hashCode}.png')
              .putFile(image))
          .ref
          .getDownloadURL();
    }

    await _firestore.collection('users').doc(userId).update({
      'hostName': host['hostName'],
      'hostPhone': host['hostPhone'],
      if (url != null) 'hostAvatar': url,
    });
  }

  @override
  Future<void> sendVerificationEmail() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  @override
  Future<User?> getUserFromCollection({String? id}) async {
    if (!await _connectionChecker.hasConnection) {
      throw Exception('No internet connection');
    }

    final userId = id ?? _auth.currentUser?.uid;
    if (userId == null) {
      return null;
    }

    final doc = await _firestore.collection('users').doc(userId).get();

    return User.fromJson(doc.data()!);
  }

  @override
  Future<void> reloadUser() async {
    await auth.FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  Future<void> verifyPhoneNumber(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (credential) async {
        await _auth.currentUser!.linkWithCredential(credential);
      },
      verificationFailed: (exception) {
        throw exception;
      },
      timeout: const Duration(seconds: 60),
      codeSent: (verificationId, resendToken) {},
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Stream<User?> watchUserFromCollection() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty();
    }
    return _firestore.collection('users').doc(userId).snapshots().map((user) {
      final data = user.data();
      if (data != null) {
        return User.fromJson(data);
      }
      return null;
    });
  }

  @override
  Future<void> checkEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userFromCollection =
          await _firestore.collection('users').doc(user.uid).get();
      if (user.emailVerified &&
          (userFromCollection.data()?['verified'] == null ||
              userFromCollection.data()?['verified'] == false)) {
        userFromCollection.reference.update({
          'verified': true,
        });
      }
    }
  }
}
