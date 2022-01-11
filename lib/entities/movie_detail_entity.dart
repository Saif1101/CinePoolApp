import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable{
  final int movieID;
  final String title;
  final String overview;
  final String releaseDate;
  final num voteAverage;
  final String backdropPath;
  final String posterPath;

  MovieDetailEntity({this.posterPath, this.movieID, this.title, this.overview, this.releaseDate, this.voteAverage, this.backdropPath});

  @override

  List<Object> get props => [movieID];

  @override
  String toString() {
    return 'MovieID: $movieID, Title: $title, PosterPath: $posterPath';
  }
}