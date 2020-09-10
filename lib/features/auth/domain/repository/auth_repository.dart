import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInAnonymously();
  Future<FirebaseUser> getCurrentUser();
  void signOutAnonymously();
}
