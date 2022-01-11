
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';


import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:dartz/dartz.dart';


import 'package:socialentertainmentclub/entities/movie_params.dart';




class CheckIfFavorite extends UseCase<bool, MovieParams>{
  final MovieRepository repository;

  CheckIfFavorite(this.repository);

  Future <Either<AppError,bool>> call(MovieParams params) async {
    return await repository.checkIfFavorite(params.movieID);
  }
}