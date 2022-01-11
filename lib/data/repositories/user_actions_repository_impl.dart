import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:socialentertainmentclub/data_sources/user_actions_remote_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

class UserActionsRepositoryImpl extends UserActionsRepository{
  final UserActionsRemoteDataSource userActionsRemoteDataSource;

  UserActionsRepositoryImpl({@required this.userActionsRemoteDataSource});

  @override
  Future<Either<AppError, void>> addFollowersAndFollowing(String userID) async {
    try{
      final response = await userActionsRemoteDataSource.addFollowerAndFollowing(userID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIFollowing(String userID) async {
    try{
      final response = await userActionsRemoteDataSource.checkIfFollowing(userID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, int>> getFollowers(String userID) async {
    try {
      final response = await userActionsRemoteDataSource.getFollowers(userID);
      return Right(response);
    }on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, int>> getFollowing(String userID) async {
    try {
      final response = await userActionsRemoteDataSource.getFollowing(userID);
      return Right(response);
    }on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> unfollowUser(String userID) async {
    try{
      final response = await userActionsRemoteDataSource.unfollowUser(userID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<UserModel>>> getSearchedUsers(String searchTerm) async {
    try{
      final response = await userActionsRemoteDataSource.getSearchedUsers(searchTerm);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }
}