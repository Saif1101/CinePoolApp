


import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';

class GetMyRecommendationPosts extends UseCase<List<AskForRecommendationsPostModel>, NoParams>{
  final RecommendationsPollRepository repository;

   GetMyRecommendationPosts(this.repository);


  @override
  Future<Either<AppError, List<AskForRecommendationsPostModel>>> call(NoParams params) async {
    return await repository.getMyAskForRecommendationPosts();
    }
}