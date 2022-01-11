

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';




class GetFavoriteMovies extends UseCase<List<FavoritedMovie>, String>{

  final MovieRepository movieRepository;

  GetFavoriteMovies(this.movieRepository);

  @override
  Future<Either<AppError, List<FavoritedMovie>>> call(String userID) async {
    return await movieRepository.getFavoriteMovies(userID);
  }
}