import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data_sources/recommendationsPolls_remote_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

class RecommendationsPollRepositoryImpl extends RecommendationsPollRepository{
  final RecommendationsPollsDataSource recommendationsPollsDataSource;

  RecommendationsPollRepositoryImpl({@required this.recommendationsPollsDataSource});

  @override
  Future<Either<AppError, void>> updateRecommendationsTrackMap(Map <String,List<String>> recommendationsTrackMap, String ownerID, String postID) async {
    try{
      final response = await recommendationsPollsDataSource.updateRecommendationsTrackMap(recommendationsTrackMap, ownerID, postID);
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> createPollPost(PollPostModel pollPost) async {
    try{
      final response = await recommendationsPollsDataSource.createPollPost(pollPost);
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future <Either<AppError,List<PollPostModel>>> getMyPollPosts() async {
    try{
      final response = await recommendationsPollsDataSource.getMyPollPosts();
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> castPollVote({Map<String, int> pollOptionsMap,
      Map<String, int> votersMap,
      String ownerID,
      String postID}) async {
    try{
      final response = await recommendationsPollsDataSource.castPollVote(
          pollOptionsMap: pollOptionsMap,
          votersMap: votersMap,
          postID: postID,
          ownerID: ownerID);
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> createRecommendationsPost(AskForRecommendationsPostModel askForRecommendationsPost) async {
    try{
      final response = await recommendationsPollsDataSource.createRecommendationsPost(askForRecommendationsPost);
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError,List<AskForRecommendationsPostModel>>> getMyAskForRecommendationPosts() async {
    try{
      final response = await recommendationsPollsDataSource.getMyAskForRecommendationPosts();
      return Right(response);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }
}