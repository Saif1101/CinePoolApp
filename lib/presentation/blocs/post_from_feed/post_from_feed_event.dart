part of 'post_from_feed_bloc.dart';

abstract class PostFromFeedEvent extends Equatable {
  const PostFromFeedEvent();

  @override
  List<Object> get props => [];
}

class LoadPostEvent extends PostFromFeedEvent{
  final FeedActivityItem feedActivityItem;

  LoadPostEvent(this.feedActivityItem); 

  @override
  List<Object> get props => [feedActivityItem];
}

class DeleteActivityForPostEvent extends PostFromFeedEvent{
  final String activityID;

  DeleteActivityForPostEvent({@required this.activityID}); 
}