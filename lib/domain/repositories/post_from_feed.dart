import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';


abstract class PostFromFeedRepository{
  Future <Either<AppError, WatchAlong>> fetchWatchAlong(String ownerID, String movieID);
  Future <Either<AppError, PollPostModel>> fetchPollPost(String ownerID, String postID);
  Future <Either<AppError, AskForRecommendationsPostModel>> fetchRecommendationPost(String ownerID, String postID);
}