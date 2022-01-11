import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_SearchedMovies.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_search_params.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final GetSearchedMovies getSearchedMovies;


  SearchMoviesBloc({@required this.getSearchedMovies}) : super(SearchMoviesInitial());

  @override
  Stream<SearchMoviesState> mapEventToState(SearchMoviesEvent event)
  async* {
    if(event is SearchMoviesTermChangedEvent){
      if(event.searchTerm.length>2){
        yield SearchMoviesLoading();
        final Either<AppError, List<MovieEntity>> response = await getSearchedMovies(MovieSearchParams(searchTerm: event.searchTerm));
        yield response.fold(
                (l) => SearchMoviesError(),
                (r) => SearchMoviesLoaded(r));
      }
    } else if(event is ClearMovieSearchResultsEvent){
      yield SearchMoviesResultsCleared();
    }
  }
}


