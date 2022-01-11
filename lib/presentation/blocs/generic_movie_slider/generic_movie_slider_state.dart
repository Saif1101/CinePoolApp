part of 'generic_movie_slider_bloc.dart';

abstract class GenericMovieSliderState extends Equatable {
  final int currentTabIndex;

  const GenericMovieSliderState({this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class GenericMovieSliderInitial extends GenericMovieSliderState {}

class GenericMoveSliderError extends GenericMovieSliderState{
  final AppErrorType errorType;
  final String errorMessage;

  GenericMoveSliderError({@required this.errorType, this.errorMessage});
}

class GenericMoveSliderLoaded extends GenericMovieSliderState {
  final Map<String,List<MovieModel>> moviesByGenreMap;
  final Map<String,String> genreIDNameMap;

  const GenericMoveSliderLoaded({this.moviesByGenreMap, this.genreIDNameMap})
      : super();

  @override
  List<Object> get props => [moviesByGenreMap];
}

