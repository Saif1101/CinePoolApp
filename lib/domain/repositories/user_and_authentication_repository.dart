import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';

abstract class UserAndAuthenticationRepository{
  Future <Either<AppError,UserModel>> getUserFromID(String userID);

  Future<Either<AppError,UserModel>> newUserSignUp(
      {String id,
         String username,
         String photoUrl,
        String email,
         Map<String, String> selectedGenres,
        String timestamp,
        String displayName}
      );
  Future <Either<AppError,void>> setUsernameAndGenres(String username, Map<String,String> genres);

  Future <Either<AppError,List<UserModel>>> getRecentUsers(); 
}