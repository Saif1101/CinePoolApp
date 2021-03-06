import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';

class MovieEntity extends Equatable{
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String overview;

   MovieEntity({
    @required this.posterPath,
     @required this.id,
    @required this.backdropPath,
  @required this.title,
  @required this.voteAverage,
  @required this.releaseDate,
  this.overview});

  @override
  // TODO: implement props
  List<Object> get props => [id,title];

  @override
  bool get stringify => true;

  factory MovieEntity.fromMovieDetailEntity(MovieDetailEntity movieDetailEntity){
    return MovieEntity(posterPath: movieDetailEntity.posterPath,
        id: movieDetailEntity.movieID,
        backdropPath: movieDetailEntity.backdropPath,
        title: movieDetailEntity.title,
        voteAverage: movieDetailEntity.voteAverage,
        releaseDate: movieDetailEntity.releaseDate);
  }

  @override
  String toString() {

    return ('movieID: ${this.id}');
  }
}