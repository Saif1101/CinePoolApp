part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailLoadEvent extends MovieDetailEvent{
  final int movieID;

  MovieDetailLoadEvent(this.movieID);

  @override

  List<Object> get props => [movieID];

}
