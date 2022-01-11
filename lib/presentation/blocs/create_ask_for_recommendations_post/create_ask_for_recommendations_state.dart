part of 'create_ask_for_recommendations_bloc.dart';



abstract class CreateAskForRecommendationsState extends Equatable{

  List<Object> get props => [];

}



class CreateAskForRecommendationsPostInitial  extends CreateAskForRecommendationsState {

  @override
  List<Object> get props => [];

}

class CreateAskForRecommendationsPostError extends CreateAskForRecommendationsState{
  final String errorMessage;
  final AppErrorType errorType;


  CreateAskForRecommendationsPostError(this. errorMessage, this.errorType);
}

class CreateAskForRecommendationsPostSuccess extends CreateAskForRecommendationsState{}

class CreateAskForRecommendationsPostLoading extends CreateAskForRecommendationsState{}

class CreateAskForRecommendationsPostLoaded extends CreateAskForRecommendationsState{
  final String title;
  final String description;
  final Map<int,String> genres;

  CreateAskForRecommendationsPostLoaded(
       this.title,
      this.description,
      this.genres);
}