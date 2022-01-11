import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationFirebaseProvider {
  final FirebaseAuth _firebaseAuth;
  AuthenticationFirebaseProvider({
    @required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Stream<User> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }
  bool checkIfUserSignedIn(){
    if(_firebaseAuth.currentUser ==null){
      return false;
    }
    return true;
  }

  Future<User> login({
    @required AuthCredential credential,
  }) async {
    UserCredential userCredential =
    await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}