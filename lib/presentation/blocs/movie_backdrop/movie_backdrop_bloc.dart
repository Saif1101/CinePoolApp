import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';



part 'movie_backdrop_event.dart';
part 'movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropInitial());

  @override
  Stream<MovieBackdropState> mapEventToState(
      MovieBackdropEvent event,
      ) async* {
    yield MovieBackdropChanged((event as MovieBackdropChangedEvent).movie);
  }
}