import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';

class Unauthenticate extends UseCase<void,NoParams>{
  final UserAndAuthenticationRepository repository;

  Unauthenticate(this.repository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return await repository.unAuthenticate();
  }
}