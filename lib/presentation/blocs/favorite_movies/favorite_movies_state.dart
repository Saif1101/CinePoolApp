part of 'favorite_movies_bloc.dart';

abstract class FavoriteMoviesState extends Equatable {
  const FavoriteMoviesState();
  @override
  List<Object> get props => [];
}

class FavoriteMoviesInitial extends FavoriteMoviesState {
}

//when you want to show all the favorited movies
class FavoriteMoviesLoaded extends FavoriteMoviesState{
  final List<FavoritedMovie> favoritedMovies;

  FavoriteMoviesLoaded({@required this.favoritedMovies});

  @override

  List<Object> get props => [favoritedMovies];
}

class FavoriteMoviesError extends FavoriteMoviesState{}

class FavoriteMoviesLoading extends FavoriteMoviesState{}

class IsFavoriteMovie extends FavoriteMoviesState{
  final bool isMovieFavorite;

  IsFavoriteMovie({@required this.isMovieFavorite});

  @override

  List<Object> get props => [isMovieFavorite];
}


