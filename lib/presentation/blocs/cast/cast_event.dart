part of 'cast_bloc.dart';

abstract class CastEvent extends Equatable {
  const CastEvent();

  @override

  List<Object> get props => [];
}

class LoadCastEvent extends CastEvent{
  final int movieID;

  LoadCastEvent({@required this.movieID});

  @override

  List<Object> get props => [movieID];
}
