part of 'activity_feed_bloc.dart';

abstract class ActivityFeedState extends Equatable {
  const ActivityFeedState();
  
  @override
  List<Object> get props => [];
}

class ActivityFeedInitial extends ActivityFeedState {}

class ActivityFeedLoading extends ActivityFeedState{}

class ActivityFeedLoaded extends ActivityFeedState{
  final List<FeedActivityItem> feedItems;

  ActivityFeedLoaded(this.feedItems); 

}

class ActivityFeedError extends ActivityFeedState{
  final String errorMessage; 
  final AppErrorType appErrorType;

  ActivityFeedError({this.errorMessage, this.appErrorType}); 
  
  @override
  List<Object> get props => [errorMessage,appErrorType];
}
