part of 'ask_for_recommendations_post_list_bloc.dart';

abstract class AskForRecommendationsPostListEvent extends Equatable {
  const AskForRecommendationsPostListEvent();

  @override
  List<Object> get props => throw [];
}

class LoadRecommendationsPostListEvent extends AskForRecommendationsPostListEvent{
  final Map<String, List<String>> recommendationsTrackMap;
  final String ownerID;
  final String postID;

  LoadRecommendationsPostListEvent({
    @required this.recommendationsTrackMap,
  @required this.ownerID,
  @required this.postID}); //{movieID, ListOfUsers who recommended this} //

  @override
  List<Object> get props => [recommendationsTrackMap];

}

class AddMovieToRecommendationsPostListEvent extends AskForRecommendationsPostListEvent{
  final Map<String,MovieDetailEntity> movies;
  final Map<String, List<String>> recommendationsTrackMap;
  final String ownerID;
  final String postID;
  final int movieID;
  final String currentUserID = FirestoreConstants.currentUserId;
  final Map <String,UserModel> users;
  final Map <String,List<UserModel>> movieUserMap;

  AddMovieToRecommendationsPostListEvent({
    @required this.movieUserMap,
    @required this.users,
    @required this.movies,
    @required this.ownerID,
    @required this.postID,
    @required this.recommendationsTrackMap,
    @required this.movieID});

  @override
  List<Object> get props => [recommendationsTrackMap, movieID];

}

class RemoveRecommendationFromPostListEvent extends AskForRecommendationsPostListEvent{
  final Map<String,MovieDetailEntity> movies;
  final Map<String, List<String>> recommendationsTrackMap;
  final String ownerID;
  final String postID;
  final String movieID;
  final String currentUserID = FirestoreConstants.currentUserId;
  final Map <String,UserModel> users;
  final Map <String,List<UserModel>> movieUserMap;

  RemoveRecommendationFromPostListEvent({
    @required this.movieUserMap,
    @required this.movies,
    @required this.users,
    @required this.ownerID,
    @required this.postID,
    @required this.recommendationsTrackMap,
    @required this.movieID
  });


}
