import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';

class GetUserFromAuthDetail extends UseCase<UserModel, AuthenticationDetail>{
  final UserAndAuthenticationRepository repository;

  GetUserFromAuthDetail(this.repository);

  @override
  Future<Either<AppError, UserModel>> call(AuthenticationDetail params) async {
    return await repository.getUserFromAuthDetail(params);
  }
}