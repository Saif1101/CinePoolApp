import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/post_from_feed.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/FetchWatchAlongParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

class GetWatchAlong extends UseCase<WatchAlong,FetchWatchAlongParams> {
  final PostFromFeedRepository repository;

  GetWatchAlong(this.repository);

  @override
  Future<Either<AppError, WatchAlong>> call(FetchWatchAlongParams params) async {
    return await repository.fetchWatchAlong(params.ownerID, params.movieID);
  }
}