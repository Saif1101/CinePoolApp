import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

import '../core/Firestore_constants.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;

  AuthRepository({
    @required this.firestore,
    @required this.firebaseAuth, 
    @required this.googleSignIn
    });

  Future<Either<AppError, bool>> checkIfUserAlreadySignedIn() async {
    try {
      final user =  firebaseAuth.currentUser;
      return Right(user == null);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch (e) {
      return Left(AppError(
          appErrorType: AppErrorType.authentication,
          errorMessage: e.toString()));
    }
  }

  Either<AppError,User > getCurrentLoggedInUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return Right(user);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch (e) {
      return Left(AppError(
          appErrorType: AppErrorType.authentication,
          errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(
        credential
      );

      DocumentSnapshot doc = await FirestoreConstants.usersRef.doc(FirebaseAuth.instance.currentUser.uid).get();
      if(doc.exists){
        return Right(UserModel.fromDocument(doc));
      }
      return Right
      (UserModel(
        displayName: FirebaseAuth.instance.currentUser.displayName,
        id: FirebaseAuth.instance.currentUser.uid,
        email: FirebaseAuth.instance.currentUser.email,
        photoUrl: FirebaseAuth.instance.currentUser.photoURL,
        registered: false ));
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch (e) {
      return Left(AppError(
          appErrorType: AppErrorType.authentication,
          errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, void>> signOut() async {
    try {
      final response = await firebaseAuth.signOut();
      await googleSignIn.signOut();
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch (e) {
      return Left(AppError(
          appErrorType: AppErrorType.authentication,
          errorMessage: e.toString()));
    }
  }

  // Future<Either<AppError, UserModel>> getFirestoreUser(
  //     String firebaseUserID) async {
  //   try {
  //     DocumentSnapshot doc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(firebaseUserID)
  //         .get();
  //     if (doc.exists) {
  //       return Right(UserModel.fromDocument(doc));
  //     } else {
  //       return Right(UserModel.empty);
  //     }
  //   } on SocketException {
  //     return Left(AppError(appErrorType: AppErrorType.network));
  //   } on Exception catch (e) {
  //     return Left(AppError(
  //         appErrorType: AppErrorType.authentication,
  //         errorMessage: e.toString()));
  //   }
  // }
}
