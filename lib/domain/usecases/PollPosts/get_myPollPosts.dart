import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';





class GetMyPollPosts extends UseCase<List<PollPostModel>, NoParams>{
  final RecommendationsPollRepository repository;

   GetMyPollPosts(this.repository);


  @override
  Future<Either<AppError, List<PollPostModel>>> call(NoParams params) async {
    return await repository.getMyPollPosts();
    }
}