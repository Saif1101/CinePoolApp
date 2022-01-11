part of 'search_movies_bloc.dart';


abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesTermChangedEvent extends SearchMoviesEvent{
  final String searchTerm;

  SearchMoviesTermChangedEvent({this.searchTerm});

  @override

  List<Object> get props => [searchTerm];
}

class ClearMovieSearchResultsEvent extends SearchMoviesEvent{}

