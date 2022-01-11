
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';

class GetAuthCredentialFromFirebaseUser extends UseCase<AuthenticationDetail, User>{
  final UserAndAuthenticationRepository repository;

  GetAuthCredentialFromFirebaseUser(this.repository);

  @override
  Future<Either<AppError, AuthenticationDetail>> call(User params) async {
    return await repository.getAuthCredentialFromFirebaseUser(user: params);
  }
}