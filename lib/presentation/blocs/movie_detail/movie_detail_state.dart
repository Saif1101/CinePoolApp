part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState{}

class MovieDetailError extends MovieDetailState{
  final AppErrorType appErrorType;
  final String errorMessage;

  MovieDetailError({@required this.appErrorType, this.errorMessage});
}

class MovieDetailLoaded extends MovieDetailState{
  final MovieDetailEntity movieDetailEntity;

  MovieDetailLoaded({this.movieDetailEntity});

  @override

  List<Object> get props => [movieDetailEntity];

}


