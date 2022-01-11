import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/GenreSearchParams.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';

//one usecase per feature

class GetMoviesByGenre extends UseCase<List<MovieEntity>, GenreSearchParams>{
  final MovieRepository repository;

  GetMoviesByGenre(this.repository);
  
  Future <Either<AppError,List<MovieEntity>>> call(GenreSearchParams genreSearchParams) async {

    return await repository.getMoviesByGenre(genreSearchParams.genreID);
  }
}