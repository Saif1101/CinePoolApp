import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/post_from_feed.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FetchRecommendationPollPostParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';

class GetRecommendationPost extends UseCase<AskForRecommendationsPostModel,FetchRecommendationPollPostParams> {
  final PostFromFeedRepository repository;

  GetRecommendationPost(this.repository);

  @override
  Future<Either<AppError, AskForRecommendationsPostModel>> call(FetchRecommendationPollPostParams params) async {
    return await repository.fetchRecommendationPost(params.ownerID, params.postID);
  }


}