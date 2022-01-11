part of 'search_page_bloc.dart';

abstract class SearchPageState extends Equatable {
  const SearchPageState();
  @override
  List<Object> get props => [];
}

class SearchPageInitial extends SearchPageState {}

class UserSearch extends SearchPageState{}

class MovieSearch extends SearchPageState{}

class UserResultsLoaded extends SearchPageState{}

class MovieResultsLoaded extends SearchPageState{}



