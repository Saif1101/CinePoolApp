import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';

class GetAuthenticationDetailFromGoogle extends UseCase<AuthenticationDetail, NoParams>{
  final UserAndAuthenticationRepository repository;

  GetAuthenticationDetailFromGoogle(this.repository);

  @override
  Future<Either<AppError, AuthenticationDetail>> call(NoParams params) async {
    return await repository.getAuthenticationDetailFromGoogle();
  }
}