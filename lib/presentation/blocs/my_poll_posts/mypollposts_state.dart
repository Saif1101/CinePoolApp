part of 'mypollposts_bloc.dart';

abstract class MyPollPostsState extends Equatable {
  const MyPollPostsState();
  
  @override
  List<Object> get props => [];
}

class MyPollPostsInitial extends MyPollPostsState {}

class MyPollPostsLoading extends MyPollPostsState {}

class MyPollPostsLoaded extends MyPollPostsState{
  final List<PollPostModel> myPollPosts;

  MyPollPostsLoaded(this.myPollPosts); 
  
}

class MyPollPostsError extends MyPollPostsState{
  final String errorMessage;
  final AppErrorType appErrorType;

  MyPollPostsError({this.errorMessage, this.appErrorType});

}
