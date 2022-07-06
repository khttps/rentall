import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  bool get isSignedIn;
  auth.User? get currentUser;
  Stream<auth.User?> get userChanges;
  Future<User> getUser({String? uid});
}

class UserRepositoryImpl implements UserRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  UserRepositoryImpl({
    auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<auth.User?> signInEmailAndPassword(
    String email,
    String password,
  ) async {
    final auth = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user;
  }

  @override
  Future<void> signOut() async {
    final googleSignedIn = await GoogleSignIn().isSignedIn();
    if (googleSignedIn) await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  @override
  auth.User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<auth.User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final auth = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (auth.user != null) {
      _firebaseFirestore.collection('users').doc(auth.user!.uid).set({
        'uid': auth.user!.uid,
        'email': auth.user!.email,
      });
    }

    return auth.user;
  }

  @override
  Future<void> sendForgotPasswordEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<auth.User?> signInWithGoogle() async {
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

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      await _firebaseFirestore.collection('users').doc(user.uid).get().then(
        (doc) {
          if (doc.exists) {
            doc.reference.set({
              'uid': user.uid,
              'displayName': user.displayName,
              'email': user.email,
            });
          }
        },
      );
    }

    return user;
  }

  @override
  Future<auth.User?> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) return null;

    final facebookAuthCredential = auth.FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );

    final credential = await _firebaseAuth.signInWithCredential(
      facebookAuthCredential,
    );

    return credential.user;
  }

  @override
  Future<bool> changeEmailAddress(
    String newEmail,
    String currentPassword,
  ) async {
    bool success = false;

    final user = _firebaseAuth.currentUser;

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
    return success;
  }

  @override
  Stream<auth.User?> get userChanges => _firebaseAuth.userChanges();

  @override
  Future<User> getUser({String? uid}) async {
    final userId = uid ?? _firebaseAuth.currentUser!.uid;
    final doc = await _firebaseFirestore.collection('users').doc(userId).get();

    return User.fromJson(doc.data()!);
  }
}
