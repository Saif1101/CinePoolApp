import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

abstract class RecommendationsPollRepository{

  //Poll Post Methods
  Future <Either<AppError,List<PollPostModel>>> getMyPollPosts();
  
  Future <Either<AppError, void>> createPollPost(
      PollPostModel pollPost,
      );

  Future <Either<AppError, void>> castPollVote(
      {Map<String, int> votersMap,
      Map<String,int> pollOptionsMap,
      String ownerID,
      String postID,}
      );

    
  Future <Either<AppError, void>> deletePollPost(String postID);





  //Recommendations Post Methods

  Future <Either<AppError, void>> createRecommendationsPost(
      AskForRecommendationsPostModel askForRecommendationsPost,
      );

  Future<Either<AppError,List<AskForRecommendationsPostModel>>> getMyAskForRecommendationPosts(); 
  
  Future <Either<AppError, void>> updateRecommendationsTrackMap(
      Map <String,List<String>> recommendationsTrackMap,
      String ownerID,
      String postID
      );

    Future <Either<AppError, void>> deleteRecommendationPost(String postID);
}
