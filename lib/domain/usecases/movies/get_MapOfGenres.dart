import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/genre_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';

import 'package:socialentertainmentclub/entities/no_params.dart';



//one usecase per feature

class GetMapOfGenres extends UseCase<Map<int,String>, NoParams>{
  final GenreRepository repository;

  GetMapOfGenres(this.repository);

  Future <Either<AppError,Map<int,String>>> call(NoParams noParams) async {
    return await repository.getMapOfGenres();
  }
//the inbuilt call function enables you to call a class without creating an instance

}