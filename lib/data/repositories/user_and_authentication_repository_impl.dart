


import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:socialentertainmentclub/data_sources/user_and_authentication_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/firebase_authentication.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/google_sign_in_provider.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';

class UserAndAuthenticationRepositoryImpl extends UserAndAuthenticationRepository{
  final AuthenticationFirebaseProvider authenticationFirebaseProvider;
  final GoogleSignInProvider googleSignInProvider;
  final UserAndAuthenticationDataSource userAndAuthenticationDataSource;

  UserAndAuthenticationRepositoryImpl({ @required this.userAndAuthenticationDataSource,
      @required this.authenticationFirebaseProvider,
        @required this.googleSignInProvider});


  Future <Either<AppError, AuthenticationDetail>> getAuthenticationDetailFromGoogle() async {
    try {
      final response = await userAndAuthenticationDataSource.getAuthenticationDetailFromGoogle();
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString()));
    }
  }

  Future<Either<AppError,UserModel>> getUserFromAuthDetail(AuthenticationDetail authenticationDetail) async {
    try {
        final response = await userAndAuthenticationDataSource.getUserFromAuthDetail(authenticationDetail);
        return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString() ));
    }
  }

  Future<Either<AppError,UserModel>> newUserSignUp(
      {@required String id,
      @required String username,
      @required String photoUrl,
      @required String email,
      @required Map<String, String> selectedGenres,
      @required String timestamp,
      @required String displayName,}
      ) async {
    try {
      final response = await userAndAuthenticationDataSource.newUserSignUp(
        id: id,
        username: username,
        photoUrl: photoUrl,
        email: email,
        selectedGenres: selectedGenres,
        timestamp: timestamp,
        displayName: displayName
      );
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage:e.toString()));
    }
  }

  Future<Either<AppError,void>> unAuthenticate() async {
    try {
     final response = await userAndAuthenticationDataSource.unAuthenticate();
     return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage:e.toString()));
    }
  }

  Either<AppError, AuthenticationDetail> getAuthCredentialFromFirebaseUser(
      {@required User user}) {
    try{
    final response = userAndAuthenticationDataSource.getAuthCredentialFromFirebaseUser(user: user);
    return Right(response);
  } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    }on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage:e.toString()));
    }
  }

  @override
  Future <Either<AppError,void>>  setUsernameAndGenres  (String username, Map<String, String> genres) async {
    try {
      final response = await userAndAuthenticationDataSource.setUsernameAndGenres(username, genres);
    return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    }on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage:e.toString()));
    }
  }

  @override
  Future<Either<AppError, GoogleSignInAccount>> getCurrentLoggedInAccount() async {
    try {
      final response = await userAndAuthenticationDataSource.getCurrentLoggedInAccount();
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    }on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage:e.toString()));
    }
  }

  @override
  Future<Either<AppError, UserModel>> getUserFromID(String userID) async {
    try {
      final response = await userAndAuthenticationDataSource.getUserFromID(userID);
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    }on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage:e.toString()));
    }
  }
}