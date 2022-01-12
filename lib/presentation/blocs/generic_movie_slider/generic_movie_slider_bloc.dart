import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MoviesByGenre.dart';
import 'package:socialentertainmentclub/entities/GenreSearchParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/MovieModel.dart';

part 'generic_movie_slider_event.dart';

part 'generic_movie_slider_state.dart';

class GenericMovieSliderBloc extends Bloc<GenericMovieSliderEvent, GenericMovieSliderState> {
  Map<String,List<MovieModel>> moviesByGenreMap= new Map();
  final GetMoviesByGenre getMoviesByGenre;

  GenericMovieSliderBloc({this.getMoviesByGenre}) : super(GenericMovieSliderInitial());

  @override
  Stream<GenericMovieSliderState> mapEventToState(
      GenericMovieSliderEvent event,
      ) async* {
    if(event is GenericMovieSliderLoadEvent){

      for(String genreID in event.genreMap.keys) {
        final genreMovies = await event.getMoviesByGenre(GenreSearchParams(genreID: genreID));
        yield genreMovies.fold(
            (l)=> GenericMoveSliderError(errorType: l.appErrorType, errorMessage: l.errorMessage),
            (movies){
              this.moviesByGenreMap[genreID]=movies;
            }
        );
      }
      yield GenericMoveSliderLoaded(genreIDNameMap: event.genreMap, moviesByGenreMap: this.moviesByGenreMap);
    }
  }
}