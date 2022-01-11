
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';

abstract class UseCase<Type,Params>{
  //Type -> What the UseCase returns (Output)
  //Params -> The parameters that have to be passed into the API Call
  Future <Either<AppError,Type>> call(Params params);
}