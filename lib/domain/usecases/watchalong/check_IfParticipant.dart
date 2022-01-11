
import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class CheckIfParticipant extends UseCase<bool,String>{
  final WatchAlongRepository repository;

  CheckIfParticipant(this.repository);

  @override
  Future<Either<AppError, bool>> call(String watchAlongID) async {
    return await repository.checkIfParticipant(watchAlongID);
  }

}