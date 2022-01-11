import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(MovieSearch());

  @override
  Stream<SearchPageState> mapEventToState(SearchPageEvent event)
  async* {
    print(event);
    if(event is UserSearchSelectEvent){
      yield UserSearch();
    }else if(event is MovieSearchSelectEvent){
      yield MovieSearch();
    }
  }
}
