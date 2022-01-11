part of 'ask_for_recommendations_post_bloc.dart';

abstract class AskForRecommendationsPostState extends Equatable {
  const AskForRecommendationsPostState();
  @override
  List<Object> get props => [];
}

class AskForRecommendationsPostInitial extends AskForRecommendationsPostState {}

class AskForRecommendationsPostError extends AskForRecommendationsPostState{
  final String errorMessage;
  final AppErrorType appErrorType;

  AskForRecommendationsPostError({this.errorMessage, this.appErrorType});

  @override
  List<Object> get props => [errorMessage,appErrorType];

}

class AskForRecommendationsPostLoading extends AskForRecommendationsPostState{}

class AskForRecommendationsPostLoaded extends AskForRecommendationsPostState{
  final UserModel postOwner;
  final AskForRecommendationsPostModel askForRecommendationsPost;

  AskForRecommendationsPostLoaded({this.postOwner, this.askForRecommendationsPost});

}

