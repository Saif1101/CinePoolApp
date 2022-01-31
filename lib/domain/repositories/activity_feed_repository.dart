import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

abstract class ActivityFeedRepository{
  Future <Either<AppError,void>> addVoteActivity(FeedActivityItem feedActivityItem); 
  Future <Either<AppError,void>>  addRecommendationActivity(FeedActivityItem feedActivityItem); 
  Future <Either<AppError,List<FeedActivityItem>>>  getFeedItems(); 
  Future <Either<AppError,void>> addNewFollowerActivity(FeedActivityItem feedActivityItem); 
  Future <Either<AppError,void>> optIntoWatchAlongActivity(FeedActivityItem feedActivityItem);
  Future  <Either<AppError,void>> deleteActivityFromFeed (String feedOwnerID, String activityID);
}