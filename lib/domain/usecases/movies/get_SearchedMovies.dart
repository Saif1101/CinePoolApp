import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';

import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_search_params.dart';

class GetSearchedMovies extends UseCase<List<MovieEntity>, MovieSearchParams>{
  final MovieRepository repository;

  GetSearchedMovies(this.repository);

  Future <Either<AppError,List<MovieEntity>>> call(MovieSearchParams movieSearchParams) async {

    return await repository.getSearchedMovies(movieSearchParams.searchTerm);
  }
}