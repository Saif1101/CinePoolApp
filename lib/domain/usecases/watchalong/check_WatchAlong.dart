
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class CheckWatchAlong extends UseCase<String,String>{
  final WatchAlongRepository repository;

  CheckWatchAlong(this.repository);

  @override
  Future<Either<AppError,String>> call(String movieID) async {
    return await repository.checkWatchAlong(movieID);
  }

}