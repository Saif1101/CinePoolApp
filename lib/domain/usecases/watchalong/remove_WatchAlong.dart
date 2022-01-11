import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class RemoveWatchAlong extends UseCase<void, String>{
  final WatchAlongRepository repository;

  RemoveWatchAlong(this.repository);

  @override
  Future<Either<AppError, void>> call(String movieID) async {
    return await repository.removeWatchAlong(movieID);
  }

}