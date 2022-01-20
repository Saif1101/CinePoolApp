part of 'poll_post_bloc.dart';

abstract class PollPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPollPostEvent extends PollPostEvent{
  final PollPostModel pollPost;

  LoadPollPostEvent(this.pollPost);

  @override
  List<Object> get props => [pollPost];

}

class DeletePollPostEvent extends PollPostEvent{
  final String postID;

  DeletePollPostEvent(this.postID); 
  
}

class UpdatePollsEvent extends PollPostEvent{
  final UserModel owner;
  final List<MovieDetailEntity> movies;
  final String postID;
  final Map<String, int> votersMap;
  final Map<String,int> pollOptionsMap;

  UpdatePollsEvent(
      {@required this.owner,
        @required this.movies,
      @required this.postID,
      @required this.votersMap,
      @required this.pollOptionsMap
      }
      );
}
