

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';


abstract class GenreRepository {
  Future <Either<AppError, Map<int,String>>> getMapOfGenres();
}