part of 'cast_bloc.dart';

abstract class CastState extends Equatable {
  const CastState();


  List<Object> get props => [];
}

class CastInitial extends CastState {}

class CastLoaded extends CastState {
  final List<CastEntity> cast;

  CastLoaded({@required this.cast});

  @override

  List<Object> get props => [cast];
}

class CastError extends CastState {}
