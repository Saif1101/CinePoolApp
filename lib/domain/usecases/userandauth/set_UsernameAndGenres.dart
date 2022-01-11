import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/EditProfileParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';


class SetUsernameAndGenres extends UseCase<void, EditProfileParams>{
  final UserAndAuthenticationRepository repository;

  SetUsernameAndGenres(this.repository);

  @override
  Future<Either<AppError, void>> call(EditProfileParams params) async {
    return await repository.setUsernameAndGenres(params.username, params.genres);
  }
}