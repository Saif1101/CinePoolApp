import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/data_sources/post_from_feed_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/post_from_feed.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class PostFromFeedRepositoryImpl extends PostFromFeedRepository{
  final PostFromFeedDataSource postFromFeedDataSource;

  PostFromFeedRepositoryImpl(this.postFromFeedDataSource);

  @override
  Future<Either<AppError, PollPostModel>> fetchPollPost(String ownerID, String postID) async {
    try{
      final post = await postFromFeedDataSource.fetchPollPost(ownerID, postID);
      return Right(post);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, AskForRecommendationsPostModel>> fetchRecommendationPost(String ownerID, String postID) async {
    try{
      final post = await postFromFeedDataSource.fetchRecommendationPost(ownerID, postID);
      return Right(post);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, WatchAlong>> fetchWatchAlong(String ownerID, String movieID) async {
    try{
      final post = await postFromFeedDataSource.fetchWatchAlong(ownerID, movieID);
      return Right(post);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString()));
    }
  } 
  
}