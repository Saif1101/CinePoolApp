part of 'mypollposts_bloc.dart';

abstract class MyPollPostsEvent extends Equatable {
  const MyPollPostsEvent();

  @override
  List<Object> get props => [];
}

class LoadMyPollPostsEvent extends MyPollPostsEvent{}