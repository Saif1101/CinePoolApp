import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MovieDetail.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/entities/movie_params.dart';
import 'package:socialentertainmentclub/presentation/blocs/cast/cast_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_form/watch_along_bloc.dart';


part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  //In the movie detail screen, we will first fetch the movie details
  // and the get the cast details
  // to get the cast details, we'll have to disptch the LoadCast event from the
  //MovieDetailBloc itself. therefore, we'll need an instance of CastBloc in MovieDEtailBloC
  final CastBloc castBloc;
  final WatchAlongFormBloc watchAlongBloc;
  final FavoriteMoviesBloc favoriteMoviesBloc;
  String currentUserID = FirestoreConstants.currentUserId;

  MovieDetailBloc({
    @required this.watchAlongBloc,
    @required this.favoriteMoviesBloc,
    @required this.castBloc,
    @required this.getMovieDetail
  }) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState
      (MovieDetailEvent event)
  async* {
    if(event is MovieDetailLoadEvent){
      final Either<AppError, MovieDetailEntity> eitherResponse =
      await getMovieDetail(MovieParams(movieID: event.movieID));

      yield eitherResponse.fold(
              (l) => MovieDetailError(appErrorType: l.appErrorType, errorMessage: l.errorMessage),
              (r) => MovieDetailLoaded(movieDetailEntity: r));
      watchAlongBloc.add(CheckIfScheduledEvent(event.movieID));
      favoriteMoviesBloc.add(CheckIfFavoriteMovieEvent(movieID: event.movieID));
      castBloc.add(LoadCastEvent(movieID: event.movieID));

    }
  }
}
