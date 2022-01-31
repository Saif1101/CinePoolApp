


import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';

class GetFeedItems extends UseCase<List<FeedActivityItem>,NoParams> {

final ActivityFeedRepository repository;

  GetFeedItems(this.repository);


  @override
  Future<Either<AppError, List<FeedActivityItem>>> call(NoParams params) async {
    return await repository.getFeedItems();
    }
}