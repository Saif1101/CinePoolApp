



import 'package:socialentertainmentclub/data/core/api_client.dart';
import 'package:socialentertainmentclub/models/CastCrewResultModel.dart';
import 'package:socialentertainmentclub/models/MovieDetailModel.dart';

import 'package:socialentertainmentclub/models/MovieResultModel.dart';
import 'package:socialentertainmentclub/models/MovieModel.dart';


abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getWeeklyTrending();
  Future<List<MovieModel>> getMoviesByGenre(String genreID);
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource{
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getWeeklyTrending() async {
    //returns a list of genre objects
    final response = await _client.get("/trending/movie/week");
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(String genreID) async {
    //returns a list of genre objects
    final response = await _client.get("/discover/movie",params: {'with_genres': genreID});
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('/movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    print(movie);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get('/movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(response).cast;
    return cast;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String searchTerm) async {
    //returns a list of genre objects
    final response = await _client.get("/search/movie",params: {'query': searchTerm});
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }
}




