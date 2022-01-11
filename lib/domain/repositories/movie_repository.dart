
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/cast_entity.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';

abstract class MovieRepository{
  //API calls to TMDB to fetch movies
  Future <Either<AppError,List<MovieEntity>>> getTrendingWeekly();
  Future <Either<AppError,List<MovieEntity>>> getMoviesByGenre(String genreID);
  Future <Either<AppError,MovieDetailEntity>> getMovieDetail(int id);
  Future<Either<AppError, List<CastEntity>>> getCastCrew(int id);
  Future <Either<AppError,List<MovieEntity>>> getSearchedMovies(String searchTerm);


  //CRUD for favorited movies
  Future <Either<AppError,void>> addMovieToFavorites (FavoritedMovie favoritedMovie);
  Future <Either<AppError,List<FavoritedMovie>>> getFavoriteMovies(String userID);
  Future <Either<AppError,void>> removeFromFavorites(int movieID);
  Future <Either<AppError,bool>> checkIfFavorite(int movieID);
}