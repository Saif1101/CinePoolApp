import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';



class OptedIntoWatchAlongActivity extends UseCase<void,FeedActivityItem> {

final ActivityFeedRepository repository;

  OptedIntoWatchAlongActivity(this.repository);


  @override
  Future<Either<AppError, void>> call(FeedActivityItem params) async {
    return await repository.optIntoWatchAlongActivity(params);
  }

}