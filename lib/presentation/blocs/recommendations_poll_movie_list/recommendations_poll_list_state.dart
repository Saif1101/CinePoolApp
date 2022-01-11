part of 'recommendations_poll_list_bloc.dart';

abstract class RecommendationsPollListState extends Equatable{
  @override
  List<Object> get props => [];
}

class RecommendationsPollListInitial extends RecommendationsPollListState {}

class RecommendationsPollListLoading extends RecommendationsPollListState{}

class RecommendationsPollListLoaded extends RecommendationsPollListState{
  final List<MovieEntity> selectedMovies;

  RecommendationsPollListLoaded({this.selectedMovies});

  @override
  List<Object> get props => [selectedMovies];
}
class SearchForMoviesState extends RecommendationsPollListState{
  final List<MovieDetailEntity> currentSelectedMovies= [];

  SearchForMoviesState({currentSelectedMovies});

  @override
  List<Object> get props => [currentSelectedMovies];
}

