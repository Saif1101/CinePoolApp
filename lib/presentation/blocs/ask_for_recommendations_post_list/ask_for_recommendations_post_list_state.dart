part of 'ask_for_recommendations_post_list_bloc.dart';

abstract class AskForRecommendationsPostListState extends Equatable {
  const AskForRecommendationsPostListState();

  @override
  List<Object> get props => [];
}

class AskForRecommendationsPostListInitial extends AskForRecommendationsPostListState {}

class AskForRecommendationsPostListLoading extends AskForRecommendationsPostListState {}

class AskForRecommendationsPostListLoaded extends AskForRecommendationsPostListState {
  final Map<String, List<String>> recommendationsTrackMap;
  final Map<String, MovieDetailEntity> movies;
  final Map <String,UserModel> users;
  final String ownerID;
  final String postID;
  final Map <String,List<UserModel>> movieUserMap;


  AskForRecommendationsPostListLoaded({
    @required this.recommendationsTrackMap,
    @required this.movies,
   @required this.users,
    @required this.ownerID,
    @required this.postID,
    @required this.movieUserMap,

  });

  @override
  List<Object> get props => [movies, users, recommendationsTrackMap];

}

class AskForRecommendationsPostListError extends AskForRecommendationsPostListState{
  final String errorMessage;
  final AppErrorType appErrorType;

  AskForRecommendationsPostListError({this.errorMessage, this.appErrorType});

}


