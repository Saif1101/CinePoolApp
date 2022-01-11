import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

abstract class UserActionsRepository{
  Future <Either<AppError, void>> addFollowersAndFollowing(String userID);
  Future <Either<AppError,int>> getFollowers(String userID);
  Future <Either<AppError,int>> getFollowing(String userID);
  Future <Either<AppError,void>> unfollowUser(String userID);
  Future <Either<AppError,bool>> checkIFollowing(String userID);
  Future <Either<AppError,List<UserModel>>> getSearchedUsers(String searchTerm);
}