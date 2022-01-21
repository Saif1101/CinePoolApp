


import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class GetWatchAlongParticipants extends UseCase<List<String>,String>{
  final WatchAlongRepository repository;

  GetWatchAlongParticipants(this.repository);

  @override
  Future<Either<AppError, List<String>>> call(String params) async {
    return await repository.getWatchAlongParticipants(params);
  }
}