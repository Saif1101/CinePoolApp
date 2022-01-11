part of 'my_watch_alongs_bloc.dart';

abstract class MyWatchAlongsState extends Equatable {
  @override
  List<Object> get props => [];
}

class MyWatchAlongsInitial extends MyWatchAlongsState {
}

class MyWatchAlongsLoading extends MyWatchAlongsState{

}

class MyWatchAlongsError extends MyWatchAlongsState{
  final String errorMessage;
  final AppErrorType appErrorType;

  MyWatchAlongsError({this.errorMessage, this.appErrorType});

}

class MyWatchAlongsLoaded extends MyWatchAlongsState{
  final List<WatchAlong> myWatchAlongs;

  MyWatchAlongsLoaded(this.myWatchAlongs);

  @override
  List<Object> get props => [myWatchAlongs];

}
