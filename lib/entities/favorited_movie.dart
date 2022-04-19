

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';

import 'movie_detail_entity.dart';

class FavoritedMovie extends MovieEntity{
  final int id;
  final String title;
  final String posterPath;

  FavoritedMovie({@required this.id,
    @required this.title,
    @required this.posterPath});

  factory FavoritedMovie.fromMovieEntity(MovieEntity movieEntity){
    return FavoritedMovie(id: movieEntity.id,
        title: movieEntity.title,
        posterPath: movieEntity.posterPath);
  }

  factory FavoritedMovie.fromMovieDetailEntity(MovieDetailEntity movieDetailEntity){
    return FavoritedMovie(id: movieDetailEntity.movieID,
        title: movieDetailEntity.title,
        posterPath: movieDetailEntity.posterPath);
  }

  factory FavoritedMovie.fromDocument(DocumentSnapshot doc){
    return FavoritedMovie(
      id: int.parse(doc['id']),
      title: doc['title'],
      posterPath: doc['posterPath']
    );
  }
}