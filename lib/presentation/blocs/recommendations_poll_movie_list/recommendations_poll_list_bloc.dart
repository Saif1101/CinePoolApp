

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

  RecommendationsPollListBloc() : super(RecommendationsPollListInitial()){
    on<AddMovieRecommendationEvent>(_onAddMovieRecommendationEvent);
    on<RemoveMovieRecommendationEvent>(_onRemoveMovieRecommendationEvent);
  }

  void _onAddMovieRecommendationEvent(
    AddMovieRecommendationEvent event, 
    Emitter<RecommendationsPollListState> emit,
  ){
      emit(RecommendationsPollListLoading());
      //need to check for duplicates
      if(!movieIDs.contains(event.selectedMovie.id)) {
        selectedMovies.add(event.selectedMovie);
        movieIDs.add(event.selectedMovie.id);
      }
      emit(RecommendationsPollListLoaded(selectedMovies: selectedMovies));
  }

  void _onRemoveMovieRecommendationEvent(
    RemoveMovieRecommendationEvent event, 
    Emitter<RecommendationsPollListState> emit,
  ){
    emit(RecommendationsPollListLoading());
    selectedMovies.removeWhere((item) =>  item.id.toString() == event.movieID);
    emit(RecommendationsPollListLoaded(selectedMovies: selectedMovies));
  }


  /* LEGACY mapEventToState
  @override
  Stream<RecommendationsPollListState> mapEventToState(RecommendationsPollListEvent event)
  async * {
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
  } */
}
