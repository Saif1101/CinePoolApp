

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';

class CreateAskForRecommendationsPost extends UseCase<void,AskForRecommendationsPostModel> {
  final RecommendationsPollRepository repository;

  CreateAskForRecommendationsPost(this.repository);


  @override
  Future<Either<AppError, void>> call(AskForRecommendationsPostModel askForRecommendationsPost) async {
    return await repository.createRecommendationsPost(askForRecommendationsPost);
  }


}