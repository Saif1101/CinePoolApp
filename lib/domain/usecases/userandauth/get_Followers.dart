import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

class GetFollowers extends UseCase<int,String>{
  final UserActionsRepository userActionsRepository;

  GetFollowers(this.userActionsRepository);

  @override
  Future<Either<AppError, int>> call(String params) async {
    return await userActionsRepository.getFollowers(params);
  }
}