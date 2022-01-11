import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_SearchedUsers.dart';
import 'package:socialentertainmentclub/entities/UserSearchParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';


part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final GetSearchedUsers getSearchedUsers;


  SearchUsersBloc({@required this.getSearchedUsers}) : super(SearchMoviesInitial());

  @override
  Stream<SearchUsersState> mapEventToState(SearchUsersEvent event)
  async* {
    if(event is SearchUsersTermChangedEvent){
      if(event.searchTerm.length>2){
        yield SearchUsersLoading();
        final Either<AppError, List<UserModel>> response = await getSearchedUsers(UserSearchParams(searchTerm: event.searchTerm));
        yield response.fold(
                (l) => SearchUsersError(),
                (r) => SearchUsersLoaded(r));
      }
    } else if (event is ClearUserSearchResultsEvent){
      yield SearchUsersResultsCleared();
    }
  }
}


