import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

class GetUserFromID extends UseCase<UserModel, String>{
  final UserAndAuthenticationRepository repository;

  GetUserFromID(this.repository);

  @override
  Future<Either<AppError, UserModel>> call(String params) async {
    return await repository.getUserFromID(params);
  }
}