part of 'favorite_movies_bloc.dart';

abstract class FavoriteMoviesEvent extends Equatable {
  const FavoriteMoviesEvent();
  @override

  List<Object> get props => [];
}

class LoadFavoriteMovieEvent extends FavoriteMoviesEvent{
  String userID;
  LoadFavoriteMovieEvent({@required this.userID});

}

class RemoveFromFavoriteEvent extends FavoriteMoviesEvent{
  final int movieID;

  RemoveFromFavoriteEvent({@required this.movieID,
  });

  @override

  List<Object> get props => [movieID];
}

//Will act as a toggle; if movie is already in favorites:unfavorite
//if movie is not in favorites: favorite it
class ToggleFavoriteMovieEvent extends FavoriteMoviesEvent{
  final MovieEntity movieEntity;
  final bool isFavorite;

  ToggleFavoriteMovieEvent({@required this.movieEntity,@required this.isFavorite});

  @override

  List<Object> get props => [movieEntity, isFavorite,];
}

class CheckIfFavoriteMovieEvent extends FavoriteMoviesEvent{
  final int movieID;

  CheckIfFavoriteMovieEvent({@required this.movieID});

  @override

  List<Object> get props => [movieID];
}


