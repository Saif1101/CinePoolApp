import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialentertainmentclub/data/repositories/auth_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';

class GetCurrentFirebaseUser extends UseCase<User, NoParams>{
  final AuthRepository repository;

  GetCurrentFirebaseUser(this.repository);

  @override
  Future<Either<AppError,User>> call(NoParams params) async {
    return repository.getCurrentLoggedInUser();
  }
}
