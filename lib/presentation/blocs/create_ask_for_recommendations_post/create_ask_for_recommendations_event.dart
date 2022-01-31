part of 'create_ask_for_recommendations_bloc.dart';

abstract class CreateAskForRecommendationsEvent  extends Equatable {
  const CreateAskForRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class LoadAskForRecommendationsEvent extends CreateAskForRecommendationsEvent{
  final String title;
  final String description;

  LoadAskForRecommendationsEvent({this.title, this.description});

  @override

  List<Object> get props =>  [title,description];

}


class CreateAskForRecommendationsButtonPress extends CreateAskForRecommendationsEvent{
  final String title;
  final String description;
  final GlobalKey<TagsState> tagStateKey;
  final Map<int,String> mapGenresWithID;
  final BuildContext context;

  CreateAskForRecommendationsButtonPress({
    @required this.description,
    @required this.context,
    @required this.mapGenresWithID,
    @required this.title,
    @required this.tagStateKey,});

  @override
  
  List<Object> get props => [title, mapGenresWithID];
}
