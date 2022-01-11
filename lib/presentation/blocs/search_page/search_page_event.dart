part of 'search_page_bloc.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object> get props => [];
}

class UserSearchSelectEvent extends SearchPageEvent{}

class MovieSearchSelectEvent extends SearchPageEvent{}

class SearchTermSubmit extends SearchPageEvent{}





