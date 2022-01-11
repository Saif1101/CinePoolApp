part of 'recommendations_poll_list_bloc.dart';

abstract class RecommendationsPollListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchRecommendationMovieEvent extends RecommendationsPollListEvent{
  final List<MovieDetailEntity> selectedMovies;

  SearchRecommendationMovieEvent({@required this.selectedMovies});

  @override
  List<Object> get props => [selectedMovies];
}

class AddMovieRecommendationEvent extends RecommendationsPollListEvent{
  final MovieEntity selectedMovie;
  AddMovieRecommendationEvent({this.selectedMovie});

  @override
  List<Object> get props => [selectedMovie];
}

class RemoveMovieRecommendationEvent extends RecommendationsPollListEvent{
  final String movieID;

  RemoveMovieRecommendationEvent(this.movieID);

  @override
  List<Object> get props => [movieID];

}
