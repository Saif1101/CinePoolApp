import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class RemoveFollower extends UseCase<void,String>{
  final UserActionsRepository userActionsRepository;

  RemoveFollower(this.userActionsRepository);

  @override
  Future<Either<AppError, void>> call(String params) async {
    return await userActionsRepository.unfollowUser(params);
  }
}