


import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';


import 'package:socialentertainmentclub/data_sources/user_and_authentication_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';



import 'package:socialentertainmentclub/models/UserModel.dart';

class UserAndAuthenticationRepositoryImpl extends UserAndAuthenticationRepository{
  final UserAndAuthenticationDataSource userAndAuthenticationDataSource;

  UserAndAuthenticationRepositoryImpl({ @required this.userAndAuthenticationDataSource,
      r});


 



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

  @override
  Future<Either<AppError, List<UserModel>>> getRecentUsers() async {
    try{
      final response = await userAndAuthenticationDataSource.getRecentUsers(); 
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage:e.toString()));
    }
  }
}