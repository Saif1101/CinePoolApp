

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/data_sources/genres_remote_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/genre_repository.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';


class GenreRepositoryImpl extends GenreRepository{
  final GenresRemoteDataSource remoteDataSource;

  GenreRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, Map<int,String>>> getMapOfGenres() async {
    try{
      final genres = await remoteDataSource.getGenres();
      return Right(genres);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString()));
    }
  }
}