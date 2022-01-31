import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';



class AddRecommendationActivity extends UseCase<void,FeedActivityItem> {

final ActivityFeedRepository repository;

  AddRecommendationActivity(this.repository);

  @override
  Future<Either<AppError, void>> call(FeedActivityItem params) async {
    return await repository.addRecommendationActivity(params);
  } 
}