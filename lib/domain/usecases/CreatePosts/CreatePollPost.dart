

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

class CreatePollPost extends UseCase<void,PollPostModel> {
  final RecommendationsPollRepository repository;

  CreatePollPost(this.repository);

  @override
  Future<Either<AppError, void>> call(PollPostModel pollPostModel) async {
    return await repository.createPollPost(pollPostModel);
  }


}