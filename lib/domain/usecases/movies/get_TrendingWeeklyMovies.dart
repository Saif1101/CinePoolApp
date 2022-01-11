import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';


//one usecase per feature

class GetTrendingWeekly extends UseCase<List<MovieEntity>, NoParams>{
  final MovieRepository repository;

  GetTrendingWeekly(this.repository);

  @override
  Future <Either<AppError,List<MovieEntity>>> call(NoParams noParams) async {
    return await repository.getTrendingWeekly();
  }
  //the inbuilt call function enables you to call a class without creating an instance

}