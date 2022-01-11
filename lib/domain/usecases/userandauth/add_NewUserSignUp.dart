import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/UserSignUpParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

class NewUserSignUp extends UseCase<UserModel, UserSignUpParams>{
  final UserAndAuthenticationRepository repository;

  NewUserSignUp(this.repository);

  @override
  Future<Either<AppError, UserModel>> call(UserSignUpParams params) async {
    return await repository.newUserSignUp(
        id: params.id,
        username: params.username,
        photoUrl: params.photoUrl,
        email: params.email,
        selectedGenres: params.selectedGenres,
        timestamp: params.timestamp,
        displayName: params.displayName
    );
  }

}