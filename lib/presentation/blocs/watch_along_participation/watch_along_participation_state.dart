part of 'watch_along_participation_bloc.dart';

abstract class WatchAlongParticipationState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchAlongParticipationInitial extends WatchAlongParticipationState {}

class IsParticipating extends WatchAlongParticipationState{
  final bool isParticipating;
  final List<UserModel> participants; 

  IsParticipating(
    {@required this.participants,
    @required this.isParticipating});

  @override
  List<Object> get props => [isParticipating];
}

class ParticipationButtonLoading extends WatchAlongParticipationState{}

class ParticipationButtonError extends WatchAlongParticipationState{
  final AppErrorType appErrorType;
  final String errorMessage;

  ParticipationButtonError({this.appErrorType, this.errorMessage});

}


