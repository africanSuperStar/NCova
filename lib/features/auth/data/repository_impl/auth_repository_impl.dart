import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<FirebaseUser> signInAnonymously() async {
    final FirebaseUser user = (await AuthRepository.firebaseAuth.signInAnonymously()).user;
    assert(user != null);
    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(await user.getIdToken() != null);
    if (Platform.isIOS) {
      // Anonymous auth doesn't show up as a provider on iOS
      assert(user.providerData.isEmpty);
    } else if (Platform.isAndroid) {
      // Anonymous auth does show up as a provider on Android
      assert(user.providerData.length == 1);
      assert(user.providerData[0].providerId == 'firebase');
      assert(user.providerData[0].uid != null);
    }

    final FirebaseUser currentUser = await AuthRepository.firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);
    return currentUser;
  }

  @override
  void signOutAnonymously() async {
    await AuthRepository.firebaseAuth.signOut();
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    final FirebaseUser currentUser = await AuthRepository.firebaseAuth.currentUser();
    return currentUser;
  }
}
