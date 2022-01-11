import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

class OptOutOfWatchAlong extends UseCase<void, WatchAlong>{
  final WatchAlongRepository repository;

  OptOutOfWatchAlong(this.repository);

  @override
  Future<Either<AppError, void>> call(WatchAlong watchAlong) async {
    return await repository.optOutOfWatchAlong(watchAlong);
  }

}