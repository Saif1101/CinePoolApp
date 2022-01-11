import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

class GetMyWatchAlongs extends UseCase<List<WatchAlong>, NoParams>{
  final WatchAlongRepository repository;

  GetMyWatchAlongs(this.repository);


  @override
  Future<Either<AppError, List<WatchAlong>>> call(NoParams params) async {
    return await repository.getMyWatchAlongs();
  }}