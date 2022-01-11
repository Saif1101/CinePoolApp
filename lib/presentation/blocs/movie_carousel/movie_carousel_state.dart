part of 'movie_carousel_bloc.dart';

abstract class MovieCarouselState extends Equatable{
  const MovieCarouselState();

  @override
  List<Object> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState{}
class MovieCarouselError extends MovieCarouselState{
  final AppErrorType errorType;
  final String errorMessage;

  MovieCarouselError({@required this.errorType, this.errorMessage});

}
class MovieCarouselLoaded extends MovieCarouselState{
  final List<MovieEntity> movies;
  final int defaultIndex;

  MovieCarouselLoaded({this.movies,
      this.defaultIndex =0,
  }): assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  @override
  List<Object> get props => [movies, defaultIndex];


}
