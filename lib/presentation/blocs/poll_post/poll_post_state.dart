part of 'poll_post_bloc.dart';

abstract class PollPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PollPostInitial extends PollPostState {
}

class PollPostLoaded extends PollPostState{
  final List<MovieDetailEntity> movies;
  final UserModel postOwner;
  final Map <String,int> pollOptionsMap;
  final Map<String, int> votersMap;

  PollPostLoaded({
    @required this.movies,
    @required this.postOwner,
    @required this.pollOptionsMap,
    @required this.votersMap
  }); //{userID, movieID}

@override
  List<Object> get props => [movies,postOwner,pollOptionsMap,votersMap];

}

class PollPostLoading extends PollPostState{}

class PollPostUpdated extends PollPostState{}

class PollPostError extends PollPostState{
  final String errorMessage;
  final AppErrorType appErrorType;

  PollPostError({this.errorMessage, this.appErrorType});

  @override
  List<Object> get props => [errorMessage,appErrorType];
}