


import 'dart:core';





import 'package:socialentertainmentclub/data/core/api_client.dart';

import 'package:socialentertainmentclub/models/GenresList.dart';


abstract class GenresRemoteDataSource {
  Future<Map<int, String>> getGenres();
}

class GenresRemoteDataSourceImpl extends GenresRemoteDataSource{
  final ApiClient _client;

  GenresRemoteDataSourceImpl(this._client);


  @override
  Future<Map<int, String>> getGenres() async {
    //returns a list of genre objects
    final response = await _client.get('/genre/movie/list');

    final genres = GenreList.fromJson(response).genres;
    Map<int, String> genreMap = new Map();
    genres.forEach((element) {genreMap[element.id]=element.name;});
    return genreMap;
  }
}