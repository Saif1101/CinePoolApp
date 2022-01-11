part of 'watch_along_participation_bloc.dart';

abstract class WatchAlongParticipationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleParticipationEvent extends WatchAlongParticipationEvent{
  final bool isParticipating;
  final WatchAlong watchAlong;

  ToggleParticipationEvent({
    @required this.isParticipating,
    @required this.watchAlong
  });

  @override
  List<Object> get props => [isParticipating,watchAlong];
}

class CheckIfParticipantEvent extends WatchAlongParticipationEvent{
  final String watchAlongID;

  CheckIfParticipantEvent(this.watchAlongID);

  @override
  List<Object> get props => [watchAlongID];
}
