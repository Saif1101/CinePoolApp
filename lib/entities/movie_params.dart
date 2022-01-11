import 'package:equatable/equatable.dart';

class MovieParams extends Equatable{
  final int movieID;

  MovieParams({this.movieID});

  @override

  List<Object> get props => [movieID];

}
