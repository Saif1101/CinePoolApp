

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data_sources/movie_preferences_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/movie_remote_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';
import 'package:socialentertainmentclub/models/CastCrewResultModel.dart';

import 'package:socialentertainmentclub/models/MovieDetailModel.dart';
import 'package:socialentertainmentclub/models/MovieModel.dart';

class MovieRepositoryImpl extends MovieRepository{
  final MovieRemoteDataSource remoteDataSource;
  final MoviePreferencesRemoteDataSource moviePreferencesRemoteDataSource;

  MovieRepositoryImpl({@required this.remoteDataSource,@required this.moviePreferencesRemoteDataSource});

  @override
  Future<Either<AppError,List<MovieModel>>> getTrendingWeekly() async{
    try{
      final movies = await remoteDataSource.getWeeklyTrending();
      return Right(movies);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError,List<MovieModel>>> getMoviesByGenre(String genreID) async {
    try{
      final movies = await remoteDataSource.getMoviesByGenre(genreID);
      return Right(movies);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try{
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try {
      final castCrew = await remoteDataSource.getCastCrew(id);
      return Right(castCrew);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getSearchedMovies(String searchTerm) async {
    try{
      final movies = await remoteDataSource.getSearchedMovies(searchTerm);
      return Right(movies);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.api, errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfFavorite(int movieID) async {

    try{
      final response = await moviePreferencesRemoteDataSource.checkIfFavorite(movieID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<FavoritedMovie>>> getFavoriteMovies(String userID) async {

    try{
      final response = await moviePreferencesRemoteDataSource.getFavoriteMovies(userID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> removeFromFavorites(int movieID) async {

    try{
      final response = await moviePreferencesRemoteDataSource.removeFromFavorites(movieID);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addMovieToFavorites (FavoritedMovie favoritedMovie) async {
    try{
      final response = await moviePreferencesRemoteDataSource.addMovieToFavorites(favoritedMovie);
      return Right(response);
    } on SocketException {
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.database,errorMessage: e.toString()));
    }
  }
}