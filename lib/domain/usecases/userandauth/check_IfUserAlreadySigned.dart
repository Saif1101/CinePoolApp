

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/data/repositories/auth_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';

class CheckIfUserAlreadySignedIn extends UseCase<bool,NoParams>{
  final AuthRepository repository;

  CheckIfUserAlreadySignedIn(this.repository);

  @override
  Future<Either<AppError, bool>> call(NoParams params) async {
    return await repository.checkIfUserAlreadySignedIn();
  }
  
}