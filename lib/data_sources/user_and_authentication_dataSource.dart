import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';

import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/firebase_authentication.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/google_sign_in_provider.dart';

abstract class UserAndAuthenticationDataSource{
  Future <void> setUsernameAndGenres(String username, Map<String,String>genres);
  Future <AuthenticationDetail> getAuthenticationDetailFromGoogle();
  Future <UserModel> getUserFromID(String userID);
  AuthenticationDetail getAuthCredentialFromFirebaseUser({User user});
  Future<UserModel> newUserSignUp(
      {String id,
        String username,
        String photoUrl,
        String email,
        Map<String, String> selectedGenres,
        String timestamp,
        String displayName}
      );
  Future<UserModel> getUserFromAuthDetail(AuthenticationDetail authenticationDetail);
  Future<void> unAuthenticate();
  Future<GoogleSignInAccount> getCurrentLoggedInAccount();
}

class UserAndAuthenticationDataSourceImpl extends UserAndAuthenticationDataSource{
  final AuthenticationFirebaseProvider authenticationFirebaseProvider;
  final GoogleSignInProvider googleSignInProvider;

  UserAndAuthenticationDataSourceImpl( {@required  this.authenticationFirebaseProvider,
    @required this.googleSignInProvider});

  @override
  Future<void> setUsernameAndGenres(String username, Map<String, String> genres) async {
   await FirestoreConstants.usersRef.doc(FirestoreConstants.currentUserId).update({
      'username': username,
      'genres': genres,
    });
  }

  @override
  Future<AuthenticationDetail> getAuthenticationDetailFromGoogle() async {
    User user = await authenticationFirebaseProvider.login(
      credential: await googleSignInProvider.login());
    AuthenticationDetail authDetail = getAuthCredentialFromFirebaseUser(user: user);
    return authDetail;
  }

  @override
  AuthenticationDetail getAuthCredentialFromFirebaseUser({User user}) {
    if (user != null) {
      return AuthenticationDetail(
        isValid: true,
        uid: user.uid,
        email: user.email,
        photoUrl: user.photoURL,
        name: user.displayName,
      );
    } else {
      return AuthenticationDetail(isValid: false);
    }
  }

  @override
  Future<UserModel> getUserFromAuthDetail(AuthenticationDetail authenticationDetail) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(authenticationDetail.uid)
        .get();
    if (doc.exists) {
      return UserModel.fromDocument(doc);
    }
    else {
      return UserModel.empty;
    }
  }

  @override
  Future<UserModel> newUserSignUp({String id, String username, String photoUrl, String email, Map<String, String> selectedGenres, String timestamp, String displayName}) async {
    FirestoreConstants.usersRef.doc(id).set({
      'id': id,
      'username': username,
      'photoUrl': photoUrl,
      'email': email,
      'displayName': displayName,
      'genres': selectedGenres,
      'timestamp': timestamp,
    });
    DocumentSnapshot doc = await await FirestoreConstants.usersRef.doc(id).get();
    return UserModel.fromDocument(doc);
  }

  @override
  Future<void> unAuthenticate() async {
    await googleSignInProvider.logout();
    await authenticationFirebaseProvider.logout();
    return;
  }

  @override
  Future<GoogleSignInAccount> getCurrentLoggedInAccount() async {
    GoogleSignInAccount googleAccount =  await googleSignInProvider.GetGoogleAccount();
    return googleAccount;
  }

  @override
  Future<UserModel> getUserFromID(userID) async {
    DocumentSnapshot doc = await FirestoreConstants.usersRef.doc(userID).get();
    return UserModel.fromDocument(doc);
  }
}