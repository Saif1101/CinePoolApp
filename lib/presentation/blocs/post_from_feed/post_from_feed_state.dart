part of 'post_from_feed_bloc.dart';

abstract class PostFromFeedState extends Equatable {
  const PostFromFeedState();
  
  @override
  List<Object> get props => [];
}

class PostFromFeedInitial extends PostFromFeedState {}

class PostDoesNotExist extends PostFromFeedState{}

class PostFromFeedLoading extends PostFromFeedState {}

class PostFromFeedError extends PostFromFeedState {
  final String errorMessage; 
  final AppErrorType appErrorType;

  PostFromFeedError({this.errorMessage, this.appErrorType}); 


}

class PostFromFeedLoaded extends PostFromFeedState {
  final Post post;

  PostFromFeedLoaded(this.post); 
}
