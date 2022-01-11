part of 'ask_for_recommendations_post_bloc.dart';

abstract class AskForRecommendationsPostEvent extends Equatable {
  const AskForRecommendationsPostEvent();

  @override
  List<Object> get props => [];
}

class LoadAskForRecommendationsPostEvent extends AskForRecommendationsPostEvent{
  final AskForRecommendationsPostModel askForRecommendationsPost;

  LoadAskForRecommendationsPostEvent(this.askForRecommendationsPost);

  @override
  List<Object> get props => [askForRecommendationsPost];
}


