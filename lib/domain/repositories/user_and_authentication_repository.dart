import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

abstract class UserAndAuthenticationRepository{
  Future <Either<AppError,UserModel>> getUserFromID(String userID);
  Future <Either<AppError, AuthenticationDetail>> getAuthenticationDetailFromGoogle();
  Either<AppError, AuthenticationDetail> getAuthCredentialFromFirebaseUser({User user});
  Future<Either<AppError,UserModel>> newUserSignUp(
      {String id,
         String username,
         String photoUrl,
        String email,
         Map<String, String> selectedGenres,
        String timestamp,
        String displayName}
      );
  Future<Either<AppError,UserModel>> getUserFromAuthDetail(AuthenticationDetail authenticationDetail);
  Future<Either<AppError,void>> unAuthenticate();
  Future<Either<AppError,GoogleSignInAccount>> getCurrentLoggedInAccount();
  Future <Either<AppError,void>> setUsernameAndGenres(String username, Map<String,String> genres);
}