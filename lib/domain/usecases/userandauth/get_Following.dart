import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class GetFollowing extends UseCase<int,String>{
  final UserActionsRepository userActionsRepository;

  GetFollowing(this.userActionsRepository);

  @override
  Future<Either<AppError, int>> call(String params) async {
    return await userActionsRepository.getFollowing(params);
  }
}