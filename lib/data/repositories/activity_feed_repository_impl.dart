
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/data_sources/activity_feed_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';

class ActivityFeedRepositoryImpl extends ActivityFeedRepository{
  final ActivityFeedDataSource activityFeedDataSource;

  ActivityFeedRepositoryImpl(this.activityFeedDataSource);

  

  @override
  Future<Either<AppError, void>> addRecommendationActivity(FeedActivityItem feedActivityItem) async {
    try{
      final response = await activityFeedDataSource.addRecommendationActivity(feedActivityItem);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addVoteActivity(FeedActivityItem feedActivityItem) async {
    try{
      final response = await activityFeedDataSource.addVoteActivity(feedActivityItem);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<FeedActivityItem>>> getFeedItems() async {
    try{
      final response = await activityFeedDataSource.getFeedItems();
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addNewFollowerActivity(FeedActivityItem feedActivityItem) async {
    try{
      final response = await activityFeedDataSource.addNewFollowerActivity(feedActivityItem);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> optIntoWatchAlongActivity(FeedActivityItem feedActivityItem) async {
    try{
      final response = await activityFeedDataSource.optIntoWatchAlongActivity(feedActivityItem);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteActivityFromFeed(String feedOwnerID, String activityID) async {
    try{
      final response = await activityFeedDataSource.deleteActivityFromFeed(feedOwnerID, activityID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }
  
}