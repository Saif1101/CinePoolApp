import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class GetGoogleAccount extends UseCase<GoogleSignInAccount, void>{
  final UserAndAuthenticationRepository repository;

  GetGoogleAccount(this.repository);

  @override
  Future<Either<AppError, GoogleSignInAccount>> call(void params) async {
    return await repository.getCurrentLoggedInAccount();
  }
}
