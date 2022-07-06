import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRepository {
  Future<User?> signInEmailAndPassword(
    String email,
    String password,
  );
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> sendForgotPasswordEmail(String email);
  Future<void> signOut();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<bool> changeEmailAddress(String newEmail, String currentPassword);
  Future<bool> changePassword(String newPassword, String currentPassword);
  bool get isSignedIn;
  User? get currentUser;
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  UserRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User?> signInEmailAndPassword(
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
    await _firebaseAuth.signOut();
  }

  @override
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final auth = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    _firebaseFirestore.collection('users').doc(auth.user!.uid).set({
      'email': auth.user!.email,
    });

    return auth.user;
  }

  @override
  Future<void> sendForgotPasswordEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Future<User?> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) return null;

    final facebookAuthCredential = FacebookAuthProvider.credential(
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

    // final user = _firebaseAuth.currentUser;
    final user = await signInEmailAndPassword('example@xx.xx', 'square');

    final credential = EmailAuthProvider.credential(
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
  Future<bool> changePassword(
    String newPassword,
    String currentPassword,
  ) async {
    bool success = false;

    // final user = _firebaseAuth.currentUser;
    final user = await signInEmailAndPassword('mohamed@gmail.com', '112233');

    final credential = EmailAuthProvider.credential(
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
}
