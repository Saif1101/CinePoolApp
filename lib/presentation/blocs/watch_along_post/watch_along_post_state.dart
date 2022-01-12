part of 'watch_along_post_bloc.dart';

abstract class WatchAlongPostState extends Equatable {
  WatchAlongPostState();

  @override
  List<Object> get props => [];
}

class WatchAlongPostLoading extends WatchAlongPostState{}

class WatchAlongPostInitial extends WatchAlongPostState {
  @override
  List<Object> get props => [];
}

class WatchAlongPostLoaded extends WatchAlongPostState{

  final WatchAlongPostModel watchAlongPostModel;


  WatchAlongPostLoaded({
  @required this.watchAlongPostModel,
  });

  @override

  List<Object> get props => [watchAlongPostModel];
}

class WatchAlongPostError extends WatchAlongPostState{
  final AppErrorType appErrorType;
  final String errorMessage;

  WatchAlongPostError({this.appErrorType, this.errorMessage});


}
