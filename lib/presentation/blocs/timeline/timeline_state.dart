part of 'timeline_bloc.dart';


abstract class TimelineState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineLoaded extends TimelineState {
  final List<Post> posts;

  TimelineLoaded({@required this.posts});

  @override

  List<Object> get props => [posts];
}

class TimelinePostsEmpty extends TimelineState{
  final List<UserModel> recentUsers;

  TimelinePostsEmpty(this.recentUsers); 

  @override

  List<Object> get props => [recentUsers];
  
}
class TimelineError extends TimelineState {
  final AppErrorType appErrorType;
  final String errorMessage;

  TimelineError(
      {this.appErrorType,  this.errorMessage});
}
