part of 'generic_movie_slider_bloc.dart';

abstract class GenericMovieSliderEvent extends Equatable {
  const GenericMovieSliderEvent();

  @override
  List<Object> get props => [];
}

class GenericMovieSliderLoadEvent extends GenericMovieSliderEvent {
  final Map<String,String> genreMap;
  final GetMoviesByGenre getMoviesByGenre;
  Map<int,List<MovieModel>> moviesByGenreMap;

  GenericMovieSliderLoadEvent({@required this.genreMap,
      @required this.getMoviesByGenre});

  @override
  List<Object> get props => [genreMap, getMoviesByGenre, moviesByGenreMap];
}
class GenericMovieSliderLoadedEvent extends GenericMovieSliderEvent {}