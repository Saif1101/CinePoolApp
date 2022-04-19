import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/data/repositories/auth_repository.dart';

import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';

class SignOut extends UseCase<void,NoParams>{
  final AuthRepository repository;

  SignOut(this.repository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}