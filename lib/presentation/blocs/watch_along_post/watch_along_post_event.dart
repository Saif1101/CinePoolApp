part of 'watch_along_post_bloc.dart';

abstract class WatchAlongPostEvent extends Equatable {
  WatchAlongPostEvent();

  @override

  List<Object> get props => [];
}

class LoadWatchAlongEvent extends WatchAlongPostEvent{
  final WatchAlong watchAlong;

  LoadWatchAlongEvent(this.watchAlong);

  @override
  List<Object> get props => [watchAlong];
}

class DeleteWatchAlongEvent extends WatchAlongPostEvent{
  final String watchAlongID; 
  final String movieID;

  DeleteWatchAlongEvent({
    @required this.watchAlongID,
   @required this.movieID}); 

  @override
  List<Object> get props => [watchAlongID, movieID];
}






