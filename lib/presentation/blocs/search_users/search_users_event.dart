part of 'search_users_bloc.dart';


abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();

  @override

  List<Object> get props => [];
}

class SearchUsersTermChangedEvent extends SearchUsersEvent{
  final String searchTerm;

  SearchUsersTermChangedEvent({this.searchTerm});

  @override

  List<Object> get props => [searchTerm];
}


class ClearUserSearchResultsEvent extends SearchUsersEvent{}

