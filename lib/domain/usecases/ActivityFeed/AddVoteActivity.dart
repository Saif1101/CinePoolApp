

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class AddVoteActivity extends UseCase<void,FeedActivityItem> {

final ActivityFeedRepository repository;

  AddVoteActivity(this.repository);

  @override
  Future<Either<AppError, void>> call(FeedActivityItem params) async {
    return await repository.addVoteActivity(params);
  } 

}