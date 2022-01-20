import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data_sources/watch_along_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';


class WatchAlongRepositoryImpl extends WatchAlongRepository{
  final WatchAlongDataSource watchAlongDataSource;

  WatchAlongRepositoryImpl({@required this.watchAlongDataSource});

  @override
  Future<Either<AppError, String>> checkWatchAlong(String movieID) async {
   try{
     final response = await watchAlongDataSource.checkWatchAlong(movieID);
     return Right(response);
   }on SocketException{
     return Left(AppError(appErrorType: AppErrorType.network));
   } on Exception catch(e){
     return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
   }
  }

  @override
  Future<Either<AppError, void>> createWatchAlong(WatchAlong watchAlong) async {
    try{
      final response = await watchAlongDataSource.createWatchAlong(watchAlong);
      return Right(response);
    }on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> optIntoWatchAlong(WatchAlong watchAlong) async {
    try{
      final response = await watchAlongDataSource.optIntoWatchAlong(watchAlong);
      return Right(response);
    }on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> optOutOfWatchAlong(WatchAlong watchAlong) async {
    try{
      final response = await watchAlongDataSource.optOutOfWatchAlong(watchAlong);
      return Right(response);
    }on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
    }
  }


  @override
  Future<Either<AppError, bool>> checkIfParticipant(String watchAlongID) async {
    try{
      final response = await watchAlongDataSource.checkIfParticipant(watchAlongID);
      return Right(response);
    }on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<WatchAlong>>> getMyWatchAlongs() async {
    try{
      final response = await watchAlongDataSource.getMyWatchAlongs();
      return Right(response);
    }on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteWatchAlong(String movieID, String watchAlongID) async {
    try{
      final response = await watchAlongDataSource.deleteWatchAlong(movieID, watchAlongID);
      return Right(response);
    }on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database, errorMessage: e.toString()));
    }
  }
}

