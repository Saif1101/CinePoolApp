import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';


import 'package:socialentertainmentclub/entities/UserSearchParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';

class GetSearchedUsers extends UseCase<List<UserModel>, UserSearchParams>{
  final UserActionsRepository repository;

   GetSearchedUsers(this.repository);

  Future <Either<AppError,List<UserModel>>> call(UserSearchParams params) async {
    return await repository.getSearchedUsers(params.searchTerm);
  }
}