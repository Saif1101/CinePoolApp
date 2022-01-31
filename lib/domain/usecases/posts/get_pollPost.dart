

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/post_from_feed.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FetchRecommendationPollPostParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

class GetPollPost extends UseCase<PollPostModel,FetchRecommendationPollPostParams> {
  final PostFromFeedRepository repository;

  GetPollPost(this.repository);

  @override
  Future<Either<AppError, PollPostModel>> call(FetchRecommendationPollPostParams params) async {
    return await repository.fetchPollPost(params.ownerID, params.postID);
  }
}