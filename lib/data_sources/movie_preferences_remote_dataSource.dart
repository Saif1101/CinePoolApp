import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';

abstract class MoviePreferencesRemoteDataSource{
  Future <void> addMovieToFavorites(FavoritedMovie favoritedMovie);
  Future <List<FavoritedMovie>> getFavoriteMovies(String userID);
  Future<void> removeFromFavorites(int movieID);
  Future<bool> checkIfFavorite(int movieID);
}

class MoviePreferencesRemoteDataSourceImpl extends MoviePreferencesRemoteDataSource{
  @override
  Future<List<FavoritedMovie>> getFavoriteMovies(String userID) async {
    List<FavoritedMovie> favoritedMovies = [];
    QuerySnapshot snapshot = await FirestoreConstants.favoritesRef.doc(userID).collection('favoritedMovies').get();
    snapshot.docs.forEach((element){favoritedMovies.add(FavoritedMovie.fromDocument(element));});
    return favoritedMovies;
  }

  @override
  Future<void> removeFromFavorites(int movieID) async {
    await FirestoreConstants.favoritesRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('favoritedMovies')
        .doc(movieID.toString())
        .delete();
  }

  @override
  Future<void> addMovieToFavorites(FavoritedMovie favoritedMovie) async {
    await FirestoreConstants.favoritesRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('favoritedMovies')
        .doc(favoritedMovie.id.toString())
        .set({
      'id':favoritedMovie.id.toString(),
      'posterPath': favoritedMovie.posterPath,
      'title': favoritedMovie.title,
    });
  }


  @override
  Future<bool> checkIfFavorite(int movieID)  async{
    DocumentSnapshot doc = await FirestoreConstants.favoritesRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('favoritedMovies')
        .doc(movieID.toString()).get();
    if(doc.exists){
      return true;
    }
    return false;
  }
}