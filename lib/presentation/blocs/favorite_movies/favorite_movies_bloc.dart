import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/add_MovieToFavorites.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/check_favorite.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_FavoriteMovies.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/remove_FavoriteMovie.dart';

import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';

import 'package:socialentertainmentclub/entities/movie_params.dart';


part 'favorite_movies_event.dart';
part 'favorite_movies_state.dart';

class FavoriteMoviesBloc extends Bloc<FavoriteMoviesEvent, FavoriteMoviesState> {
  //Will need to call usecases here
  final AddMovieToFavorites addMovieToFavorites;
  final GetFavoriteMovies getFavoritemovies;
  final RemoveFavoriteMovie removeFavoriteMovie;
  final CheckIfFavorite checkIfFavorite;

  FavoriteMoviesBloc({@required this.addMovieToFavorites,
    @required this.getFavoritemovies,
    @required this.removeFavoriteMovie,
    @required  this.checkIfFavorite}) : super(FavoriteMoviesInitial());

  @override
  Stream<FavoriteMoviesState> mapEventToState(FavoriteMoviesEvent event)
  async* {
    if(event is ToggleFavoriteMovieEvent){
      if(event.isFavorite){
        await removeFavoriteMovie(MovieParams(movieID: event.movieEntity.id));
      } else {
        await addMovieToFavorites(event.movieEntity);
      }
        final response = await checkIfFavorite(MovieParams(
            movieID: event.movieEntity.id));
        yield response.fold(
                (l) => FavoriteMoviesError(),
                (r) => IsFavoriteMovie(isMovieFavorite: r)
        );
    } else if (event is LoadFavoriteMovieEvent) {
      yield FavoriteMoviesLoading();
      yield* _fetchLoadFavoriteMovies(event.userID);
    } else if (event is RemoveFromFavoriteEvent){
      await removeFavoriteMovie(MovieParams(movieID: event.movieID));
      yield* _fetchLoadFavoriteMovies(FirestoreConstants.currentUserId);
    } else if(event is CheckIfFavoriteMovieEvent){
      final response = await checkIfFavorite(MovieParams(movieID: event.movieID));
      yield response.fold(
              (l) =>  FavoriteMoviesError(),
              (r) => IsFavoriteMovie(isMovieFavorite: r)
      );
    }
  }

  Stream<FavoriteMoviesState> _fetchLoadFavoriteMovies(String userID) async*{
    final Either<AppError, List<MovieEntity>> response =
    await getFavoritemovies(userID);

    yield response.fold(
            (l) => FavoriteMoviesError(),
            (r) => FavoriteMoviesLoaded(favoritedMovies: r)
    );
  }
}
