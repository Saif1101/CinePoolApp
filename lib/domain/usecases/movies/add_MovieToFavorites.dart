import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';


class AddMovieToFavorites extends UseCase<void,MovieEntity>{

  final MovieRepository movieRepository;

  AddMovieToFavorites(this.movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    print('inside usecase ${params.id}');
    return await movieRepository.addMovieToFavorites(FavoritedMovie.fromMovieEntity(params));
  }
}