import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/data/repositories/auth_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

class SignInWithGoogle extends UseCase<UserModel,NoParams>{
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<AppError, UserModel>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}