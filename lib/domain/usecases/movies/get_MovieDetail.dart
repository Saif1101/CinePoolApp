

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/entities/movie_params.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity,MovieParams>{
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future <Either<AppError,MovieDetailEntity>> call(MovieParams movieParams) async {
    return await repository.getMovieDetail(movieParams.movieID);
  }

}