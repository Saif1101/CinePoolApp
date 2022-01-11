import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';

import 'package:socialentertainmentclub/entities/movie_params.dart';

class RemoveFavoriteMovie extends UseCase<void,MovieParams>{

  final MovieRepository movieRepository;

  RemoveFavoriteMovie(this.movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieParams params) async {
    return await movieRepository.removeFromFavorites(params.movieID);
  }
}