part of 'watch_along_participation_bloc.dart';

abstract class WatchAlongParticipationState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchAlongParticipationInitial extends WatchAlongParticipationState {}

class IsParticipating extends WatchAlongParticipationState{
  final bool isParticipating;

  IsParticipating(this.isParticipating);

  @override
  List<Object> get props => [isParticipating];
}

class ParticipationButtonLoading extends WatchAlongParticipationState{}

class ParticipationButtonError extends WatchAlongParticipationState{}


