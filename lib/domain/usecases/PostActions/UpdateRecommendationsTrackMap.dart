
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/UpdateRecommendationsTrackMapParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class UpdateRecommendationsTrackMap extends UseCase<void,UpdateRecommendationsTrackMapParams> {
  final RecommendationsPollRepository repository;

  UpdateRecommendationsTrackMap(this.repository);



  @override
  Future<Either<AppError, void>> call(UpdateRecommendationsTrackMapParams params) async {
    return await repository.updateRecommendationsTrackMap(params.recommendationsTrackMap, params.ownerID, params.postID);
  }


}