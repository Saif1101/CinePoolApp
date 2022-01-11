import 'MovieModel.dart';

class MovieResultModel {

  List<MovieModel> movies;

  MovieResultModel(
      {this.movies});

  MovieResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies =  <MovieModel>[];
      json['results'].forEach((v) {
        movies.add(new MovieModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


