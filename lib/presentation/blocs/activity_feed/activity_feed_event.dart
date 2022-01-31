part of 'activity_feed_bloc.dart';

abstract class ActivityFeedEvent extends Equatable {
  const ActivityFeedEvent();

  @override
  List<Object> get props => [];
}

class LoadActivityFeedEvent extends ActivityFeedEvent {}
