import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class CheckIfFollowing extends UseCase<bool, String>{
  final UserActionsRepository userActionsRepository;

  CheckIfFollowing(this.userActionsRepository);

  @override
  Future<Either<AppError, bool>> call(String params) async {
    return await userActionsRepository.checkIFollowing(params);
  }
}