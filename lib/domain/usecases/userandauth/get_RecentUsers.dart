import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

class GetRecentUsers extends UseCase<List<UserModel>,NoParams>{
  final UserAndAuthenticationRepository repository;

  GetRecentUsers(this.repository);

  Future <Either<AppError,List<UserModel>>> call(NoParams parms) async {
    return await repository.getRecentUsers();
  }
}