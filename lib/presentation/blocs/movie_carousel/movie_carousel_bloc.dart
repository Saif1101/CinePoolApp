import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_TrendingWeeklyMovies.dart';

import 'dart:async';

import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';


part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';


class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState>
{
  final GetTrendingWeekly getTrendingWeekly;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc({ 
    @required this.movieBackdropBloc,
    @required this.getTrendingWeekly}
    ):super(MovieCarouselInitial()){
        on<CarouselLoadEvent>(_onCarouselLoadEvent);
      }

    Future<void> _onCarouselLoadEvent(
      CarouselLoadEvent event, 
      Emitter<MovieCarouselState> emit, 
    ) async {
      final moviesEither = await getTrendingWeekly(NoParams());
      emit (moviesEither.fold(
          (l)=> MovieCarouselError(errorType: l.appErrorType, errorMessage: l.errorMessage),
          (movies){
            movieBackdropBloc.add(MovieBackdropChangedEvent(movies[event.defaultIndex]));
            return MovieCarouselLoaded(
              movies: movies,
              defaultIndex: event.defaultIndex,
            );
          }
        )
      );
    }
  
  /*

  @override
  Stream<MovieCarouselState> mapEventToState(MovieCarouselEvent event)
    async*{
    if(event is CarouselLoadEvent){
      final moviesEither = await getTrendingWeekly(NoParams());
      yield moviesEither.fold(
          (l)=> MovieCarouselError(errorType: l.appErrorType, errorMessage: l.errorMessage),
          (movies){
            movieBackdropBloc.add(MovieBackdropChangedEvent(movies[event.defaultIndex]));
            return MovieCarouselLoaded(
              movies: movies,
              defaultIndex: event.defaultIndex,
            );
          }
      );

    }
  }
  */
}



  
