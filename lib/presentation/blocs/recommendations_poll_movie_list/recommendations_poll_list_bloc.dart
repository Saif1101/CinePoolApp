import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';

part 'recommendations_poll_list_event.dart';
part 'recommendations_poll_list_state.dart';

class RecommendationsPollListBloc extends Bloc<RecommendationsPollListEvent, RecommendationsPollListState> {
  final List<MovieEntity> selectedMovies = [];
  final List<int> movieIDs = [];

  RecommendationsPollListBloc() : super(RecommendationsPollListInitial());

  @override
  Stream<RecommendationsPollListState> mapEventToState(RecommendationsPollListEvent event)
  async * {
    print('Incoming event : RecommendationsPollList : $event');
    if(event is AddMovieRecommendationEvent){
      yield RecommendationsPollListLoading();
      //need to check for duplicates
      if(!movieIDs.contains(event.selectedMovie.id)) {
        selectedMovies.add(event.selectedMovie);
        movieIDs.add(event.selectedMovie.id);
      }
      yield RecommendationsPollListLoaded(selectedMovies: selectedMovies);
    } else if(event is RemoveMovieRecommendationEvent){
      yield RecommendationsPollListLoading();
      selectedMovies.removeWhere((item) =>  item.id.toString() == event.movieID);
      yield RecommendationsPollListLoaded(selectedMovies: selectedMovies);
    }
  }
}
