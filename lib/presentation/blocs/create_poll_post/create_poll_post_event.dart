part of 'create_poll_post_bloc.dart';

abstract class PollPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class LoadCreatePollPostPage extends PollPostEvent{
  final List<MovieDetailEntity> movies;
  final String title;


  LoadCreatePollPostPage({this.movies, this.title});
}

class CreatePollPostSubmitEvent extends PollPostEvent{
  final List<MovieEntity> movies;
  final String title;

  final BuildContext context;

  CreatePollPostSubmitEvent(
      {@required this.movies,
  @required this.title,

  @required this.context,}
      );
}