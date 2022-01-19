
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/DeleteWatchAlongParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class DeleteWatchAlong extends UseCase<void,DeleteWatchAlongParams>{
  final WatchAlongRepository repository;

  DeleteWatchAlong(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteWatchAlongParams params) async {
    return await repository.deleteWatchAlong(params.movieID, params.watchAlongID);
  }
}