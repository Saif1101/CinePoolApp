part of 'watch_along_bloc.dart';

abstract class WatchAlongEvent extends Equatable {
  const WatchAlongEvent();

  @override
  List<Object> get props => [];
}

class ToggleScheduleWatchAlongEvent extends WatchAlongEvent{
  final bool isScheduled;
  final String movieID;

  ToggleScheduleWatchAlongEvent({@required this.isScheduled,
   @required this.movieID});

  @override
  List<Object> get props => [isScheduled];
}


class CheckIfScheduledEvent extends WatchAlongEvent{
  final int movieID;

  CheckIfScheduledEvent(this.movieID);

}

class WatchAlongDateEditEvent extends WatchAlongEvent{
  final DateTime dateTime;
  final String movieID;

  WatchAlongDateEditEvent(this.dateTime, this.movieID);

  @override
  List<Object> get props => [dateTime];
}

class WatchAlongSubmitEvent extends WatchAlongEvent{
  final String location;
  final String movieID;
  final String title;
  final DateTime scheduledTime;

  WatchAlongSubmitEvent({
    @required this.location,
    @required this.movieID,
    @required this.title,
    @required this.scheduledTime});

  @override
  List<Object> get props => [movieID, title, scheduledTime];

}
