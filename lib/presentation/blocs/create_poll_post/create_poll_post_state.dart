part of 'create_poll_post_bloc.dart';

abstract class PollPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePollPostInitial extends PollPostState {}

class CreatePollPostError extends PollPostState {
  final String errorMessage;
  final AppErrorType errorType;

  CreatePollPostError({this.errorMessage, this.errorType});
}

class CreatePollPostLoading extends PollPostState{}

class CreatePollPostLoaded extends PollPostState{
  final String title;


  CreatePollPostLoaded({
    @required this.title,
  });
}

class CreatePollPostSubmitted extends PollPostState{}

