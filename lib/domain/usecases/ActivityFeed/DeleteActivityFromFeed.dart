

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/DeleteActivityFromFeedParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class DeleteActivityFromFeed extends UseCase<void,DeleteActivityFromFeedParams> {

final ActivityFeedRepository repository;

  DeleteActivityFromFeed(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteActivityFromFeedParams params) async {
    return await repository.deleteActivityFromFeed(params.feedOwnerID, params.activityID);
  }
}