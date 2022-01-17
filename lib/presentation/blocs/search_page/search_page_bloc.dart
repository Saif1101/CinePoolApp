import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(MovieSearch()){
    on<UserSearchSelectEvent>(_onUserSearchSelectEvent);
    on<MovieSearchSelectEvent>(_onMovieSearchSelectEvent);
  }

  void _onUserSearchSelectEvent(
    UserSearchSelectEvent event, 
    Emitter<SearchPageState> emit,
  ){
    emit(UserSearch());
  }

  void _onMovieSearchSelectEvent(
    MovieSearchSelectEvent event, 
    Emitter<SearchPageState> emit,
  ){
    emit(MovieSearch());
  }

/* LEGACY mapEventToState
  @override
  Stream<SearchPageState> mapEventToState(SearchPageEvent event)
  async* {
    if(event is UserSearchSelectEvent){
      yield UserSearch();
    }else if(event is MovieSearchSelectEvent){
      yield MovieSearch();
    }
  }

  */
}
