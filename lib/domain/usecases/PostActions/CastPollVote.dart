import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/CastPollVoteParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class CastPollVote extends UseCase<void, CastPollVoteParams> {
  final RecommendationsPollRepository repository;

  CastPollVote(this.repository);

  @override
  Future<Either<AppError, void>> call(CastPollVoteParams params) async {
    return await repository.castPollVote(
      votersMap: params.votersMap,
      postID: params.postID,
      pollOptionsMap: params.pollOptionsMap,
      ownerID: params.ownerID,
    );
  }

}