part of 'watch_along_bloc.dart';

abstract class WatchAlongState extends Equatable {
  const WatchAlongState();

  @override
  List<Object> get props => [];
}

class WatchAlongInitial extends WatchAlongState {}

class WatchAlongLoading extends WatchAlongState{}

class WatchAlongError extends WatchAlongState{}



class IsScheduled extends WatchAlongState{
  final String watchAlongID;

  IsScheduled(this.watchAlongID);

}

class CreateWatchAlongState extends WatchAlongState{
  final String movieID;
  final DateTime currentDateTime;

  CreateWatchAlongState(this.movieID, this.currentDateTime);

}

class RemoveWatchAlongState extends WatchAlongState{}

