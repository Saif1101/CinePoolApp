import 'package:socialentertainmentclub/entities/MovieEntity.dart';

class MovieModel extends MovieEntity{
  final bool video;
  final double voteAverage;
  final String overview;
  final String releaseDate;
  final int id;
  final bool adult;
  final String backdropPath;
  final int voteCount;
  final List<int> genreIds;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String posterPath;
  final double popularity;
  final String mediaType;

  MovieModel(
      {this.video,
        this.voteAverage,
        this.overview,
        this.releaseDate,
        this.id,
        this.adult,
        this.backdropPath,
        this.voteCount,
        this.genreIds,
        this.title,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.popularity,
        this.mediaType}) : super(
    id: id,
    title: title,
    backdropPath: backdropPath,
    posterPath: posterPath,
    releaseDate: releaseDate,
    voteAverage: voteAverage,
    overview: overview,
  );

  //If the returned value from is not a double, the convert library fails to parse it therefore we explicitly convert it to double

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(video : json['video'],
    voteAverage : json['vote_average']?.toDouble()??0.0,
    overview : json['overview'],
    releaseDate: json['release_date'],
    id : json['id'],
    adult : json['adult'],
    backdropPath : json['backdrop_path'],
    voteCount : json['vote_count'],
    genreIds : json['genre_ids'].cast<int>(),
    title : json['title'],
    originalLanguage : json['original_language'],
    originalTitle : json['original_title'],
    posterPath : json['poster_path'],
    popularity : json['popularity']?.toDouble()??0.0,
    mediaType : json['media_type'],);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['vote_count'] = this.voteCount;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}