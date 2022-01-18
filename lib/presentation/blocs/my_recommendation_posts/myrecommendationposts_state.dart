part of 'myrecommendationposts_bloc.dart';

abstract class MyRecommendationPostsState extends Equatable {
  const MyRecommendationPostsState();
  
  @override
  List<Object> get props => [];
}

class MyRecommendationPostsInitial extends MyRecommendationPostsState {}

class MyRecommendationPostsLoading extends MyRecommendationPostsState {}


class MyRecommendationPostsError extends MyRecommendationPostsState {
  final String errorMessage;
  final AppErrorType appErrorType;

  MyRecommendationPostsError({this.errorMessage, this.appErrorType}); 

  @override

  List<Object> get props => [errorMessage, appErrorType];
}


class MyRecommendationPostsLoaded extends MyRecommendationPostsState {
  final List<AskForRecommendationsPostModel> myRecommendationPosts;

  MyRecommendationPostsLoaded(this.myRecommendationPosts); 

   @override

  List<Object> get props => [myRecommendationPosts];
}
