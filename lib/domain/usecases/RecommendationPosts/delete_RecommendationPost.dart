



import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class DeleteRecommendationPost extends UseCase<void,String>{
  final RecommendationsPollRepository repository;

  DeleteRecommendationPost(this.repository);

  @override
  Future<Either<AppError, void>> call(String postID) async {
    return await repository.deleteRecommendationPost(postID);
  }
}