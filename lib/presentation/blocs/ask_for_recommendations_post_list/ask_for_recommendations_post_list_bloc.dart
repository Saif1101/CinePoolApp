import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/AddRecommendationActivity.dart';

import 'package:socialentertainmentclub/domain/usecases/PostActions/UpdateRecommendationsTrackMap.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MovieDetail.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/UpdateRecommendationsTrackMapParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/entities/movie_params.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

part 'ask_for_recommendations_post_list_event.dart';
part 'ask_for_recommendations_post_list_state.dart';

class AskForRecommendationsPostListBloc extends Bloc<AskForRecommendationsPostListEvent, AskForRecommendationsPostListState> {
  final GetUserFromID getUserFromID;
  final GetMovieDetail getMovieDetail;
  final UpdateRecommendationsTrackMap updateRecommendationsTrackMap;
  final AddRecommendationActivity addRecommendationActivity;




  AskForRecommendationsPostListBloc({
    @required this.addRecommendationActivity,
    @required this.updateRecommendationsTrackMap,
    @required this.getUserFromID,
    @required this.getMovieDetail
  }) : super(AskForRecommendationsPostListInitial()){

    on<LoadRecommendationsPostListEvent>(_onLoadRecommendationsPostListEvent);

    on<AddMovieToRecommendationsPostListEvent>(_onAddMovieToRecommendationsPostListEvent); 

    on<RemoveRecommendationFromPostListEvent>(_onRemoveRecommendationFromPostListEvent);
  }

  Future<void> _onLoadRecommendationsPostListEvent(
    LoadRecommendationsPostListEvent event, 
    Emitter<AskForRecommendationsPostListState> emit,
  ) async {
     emit(AskForRecommendationsPostListLoading());

      Map<String,MovieDetailEntity> movies={};
      Map <String,UserModel> users={};
      Map <String,List<UserModel>> movieUserMap={};

      int errorFlag = 0;
      String errorMessage='';
      AppErrorType appErrorType;

       Set<String> userIDs = Set();
       Set<String> movieIDs = Set();

      event.recommendationsTrackMap.values.forEach((element) {element.forEach((element) {userIDs.add(element);});});
      event.recommendationsTrackMap.keys.forEach((element) {movieIDs.add(element);});


      for(int i= 0; i<movieIDs.length; i++){
        final response = await getMovieDetail(MovieParams(movieID: int.parse(movieIDs.elementAt(i))));
        if(response.isRight()){
          movies[movieIDs.elementAt(i)] = response.getOrElse(null);
        } else {
          errorFlag = 1;
          errorMessage +=  'Error fetching Movie Details for post.-';
        }
      }


      for(int i= 0; i<userIDs.length; i++){
        final response = await getUserFromID(userIDs.elementAt(i));
        if(response.isRight()){
          users[userIDs.elementAt(i)]=response.getOrElse(null);
        }else{
          errorFlag = 1;
          errorMessage += "Error adding user details for recommendations. ";
        }
      }

      for(int i = 0 ; i<movieIDs.length; i++){
        for(int j = 0; j<event.recommendationsTrackMap[movieIDs.elementAt(i)].length;j++ ){
          if(movieUserMap[movieIDs.elementAt(i)] == null)
            movieUserMap[movieIDs.elementAt(i)]=[users[event.recommendationsTrackMap[movieIDs.elementAt(i)].elementAt(j)]];
          else
            movieUserMap[movieIDs.elementAt(i)].add(users[event.recommendationsTrackMap[movieIDs.elementAt(i)].elementAt(j)]);
        }
      }

      if(errorFlag == 0){

        emit(AskForRecommendationsPostListLoaded(
          ownerID:event.ownerID,
          postID: event.postID,
          users: users,
          recommendationsTrackMap: event.recommendationsTrackMap,
          movies: movies,
          movieUserMap : movieUserMap, 
          postTitle: event.postTitle,
        ));
      } else{
        emit (AskForRecommendationsPostListError(errorMessage: errorMessage, appErrorType: appErrorType));
      }
  }

  Future<void> _onAddMovieToRecommendationsPostListEvent(
    AddMovieToRecommendationsPostListEvent event, 
    Emitter<AskForRecommendationsPostListState> emit,
  ) async {
    emit(AskForRecommendationsPostListLoading());
      int errorFlag = 0;
      String errorMessage;
      AppErrorType appErrorType;
      if(event.recommendationsTrackMap.keys.contains(event.movieID)){
        if(!event.recommendationsTrackMap[event.movieID].contains(FirestoreConstants.currentUserId)){
          //Since the movie does not contain the user's vote, we will have to add
          //the user to this movie's entry inside the the movieUserMap
          event.movieUserMap[event.movieID.toString()].add(FirestoreConstants.currentUser);
          //add UsersID to movie's key in the recommendationsTrackMap
          event.recommendationsTrackMap[event.movieID].add(FirestoreConstants.currentUserId);

          if(!event.users.containsKey(FirestoreConstants.currentUserId)){
            //Map of <uid, usermodel> does not contain the current users model
            event.users[FirestoreConstants.currentUserId] = FirestoreConstants.currentUser;
          }
        }
        else
          {
         //Do nothing if the the user's vote has already been cast
        }
      } else {

        if(!event.users.containsKey(FirestoreConstants.currentUserId)){event.users[FirestoreConstants.currentUserId] = FirestoreConstants.currentUser;} //

        event.movieUserMap[event.movieID.toString()] = [FirestoreConstants.currentUser];

        final newMovieResponse = await getMovieDetail(MovieParams(movieID: event.movieID));
        if(newMovieResponse.isRight()){
          MovieDetailEntity newMovie = newMovieResponse.getOrElse(null);
          event.movies[event.movieID.toString()] = newMovie;
        }else{
          errorFlag=1; errorMessage= "Error occurred during adding new movie";
        }
        event.recommendationsTrackMap[event.movieID.toString()] = [event.currentUserID];
      }

      final response = await updateRecommendationsTrackMap(UpdateRecommendationsTrackMapParams(
          recommendationsTrackMap:  event.recommendationsTrackMap,
          postID: event.postID,
          ownerID: event.ownerID));

      await addRecommendationActivity(VoteRecommendActivity(
            username: FirestoreConstants.currentUser.username,
            timestamp: DateTime.now(), 
            type: 'AddRecommendation', 
            postOwnerID: event.ownerID, 
            userPhotoURL: FirestoreConstants.currentUser.photoUrl, 
            actorUserID:FirestoreConstants.currentUserId, 
            postID: event.postID, 
            postTitle: event.postTitle, 
   ));

      if(errorFlag == 1) {
        emit(AskForRecommendationsPostListError(errorMessage: errorMessage, appErrorType: appErrorType));
      } 
      else
      {
        emit (
          response.fold(
          (l) => AskForRecommendationsPostListError(errorMessage: l.errorMessage, appErrorType: l.appErrorType),
          (r) => AskForRecommendationsPostListLoaded(
            users: event.users,
            recommendationsTrackMap: event.recommendationsTrackMap,
            movies: event.movies,
            postID: event.postID,
             movieUserMap: event.movieUserMap,
             ownerID: event.ownerID, 
             postTitle: event.postTitle,
             ),
            )
          );
        }
      }
  

  Future<void> _onRemoveRecommendationFromPostListEvent(
    RemoveRecommendationFromPostListEvent event, 
    Emitter<AskForRecommendationsPostListState> emit,
  ) async {
    emit(AskForRecommendationsPostListLoading());
      if(event.recommendationsTrackMap.keys.contains(event.movieID)){
        if(event.recommendationsTrackMap[event.movieID].contains(event.currentUserID)){
          event.recommendationsTrackMap[event.movieID].remove(FirestoreConstants.currentUserId);

          event.movieUserMap[event.movieID.toString()].removeWhere(
                  (element) => element.id == FirestoreConstants.currentUserId
          );

          if(event.recommendationsTrackMap[event.movieID].length==0){
            //Remove the entire recommendation if no voters are left in it
            event.recommendationsTrackMap.remove(event.movieID);
            event.users.remove(event.currentUserID);//Valid because one user can only vote for one movie
            event.movies.remove(event.movieID);
            event.movieUserMap.remove(event.movieID);
          }
          print("Updating new track map ${event.recommendationsTrackMap} to ${event.ownerID} and postID: ${event.postID}");
          final response = await updateRecommendationsTrackMap(UpdateRecommendationsTrackMapParams(
              recommendationsTrackMap: event.recommendationsTrackMap,
              postID: event.postID,
              ownerID: event.ownerID));
          
        
    
          emit(
            response.fold(
                (l) => AskForRecommendationsPostListError(errorMessage: l.errorMessage, appErrorType: l.appErrorType),
                (r) => AskForRecommendationsPostListLoaded(
                    users: event.users,
                    recommendationsTrackMap: event.recommendationsTrackMap,
                    movies: event.movies,
                    ownerID: event.ownerID,
                    postID: event.postID,
                    movieUserMap: event.movieUserMap, 
                    postTitle: event.postTitle),
                    )
                );
        } else {
          print("The recommendationsTrackMap"
              "contains the movie ${event.movieID} but does"
              "not contain ${FirestoreConstants.currentUserId}'s vote");
        }
      }else{
        print("The recommendationTrack map does not contain the movie ${event.movieID}");
      }
  }
  

  /* LEGACY mapEventToState
  @override
  Stream<AskForRecommendationsPostListState> mapEventToState(AskForRecommendationsPostListEvent event)
  async* {
    if (event is LoadRecommendationsPostListEvent){
      yield AskForRecommendationsPostListLoading();

      Map<String,MovieDetailEntity> movies={};
      Map <String,UserModel> users={};
      Map <String,List<UserModel>> movieUserMap={};

      int errorFlag = 0;
      String errorMessage='';
      AppErrorType appErrorType;

       Set<String> userIDs = Set();
       Set<String> movieIDs = Set();

      event.recommendationsTrackMap.values.forEach((element) {element.forEach((element) {userIDs.add(element);});});
      event.recommendationsTrackMap.keys.forEach((element) {movieIDs.add(element);});


      for(int i= 0; i<movieIDs.length; i++){
        final response = await getMovieDetail(MovieParams(movieID: int.parse(movieIDs.elementAt(i))));
        if(response.isRight()){
          movies[movieIDs.elementAt(i)] = response.getOrElse(null);
        } else {
          errorFlag = 1;
          errorMessage +=  'Error fetching Movie Details for post.-';
        }
      }


      for(int i= 0; i<userIDs.length; i++){
        final response = await getUserFromID(userIDs.elementAt(i));
        if(response.isRight()){
          users[userIDs.elementAt(i)]=response.getOrElse(null);
        }else{
          errorFlag = 1;
          errorMessage += "Error adding user details for recommendations. ";
        }
      }

      for(int i = 0 ; i<movieIDs.length; i++){
        for(int j = 0; j<event.recommendationsTrackMap[movieIDs.elementAt(i)].length;j++ ){
          if(movieUserMap[movieIDs.elementAt(i)] == null)
            movieUserMap[movieIDs.elementAt(i)]=[users[event.recommendationsTrackMap[movieIDs.elementAt(i)].elementAt(j)]];
          else
            movieUserMap[movieIDs.elementAt(i)].add(users[event.recommendationsTrackMap[movieIDs.elementAt(i)].elementAt(j)]);
        }
      }

      if(errorFlag == 0){

        yield AskForRecommendationsPostListLoaded(
          ownerID:event.ownerID,
          postID: event.postID,
          users: users,
          recommendationsTrackMap: event.recommendationsTrackMap,
          movies: movies,
          movieUserMap : movieUserMap,
        );
      } else{
        yield AskForRecommendationsPostListError(errorMessage: errorMessage, appErrorType: appErrorType);
      }
    }
    
    else if(event is AddMovieToRecommendationsPostListEvent){
      yield AskForRecommendationsPostListLoading();
      int errorFlag = 0;
      String errorMessage;
      AppErrorType appErrorType;
      if(event.recommendationsTrackMap.keys.contains(event.movieID)){
        if(!event.recommendationsTrackMap[event.movieID].contains(FirestoreConstants.currentUserId)){
          //Since the movie does not contain the user's vote, we will have to add
          //the user to this movie's entry inside the the movieUserMap
          event.movieUserMap[event.movieID.toString()].add(FirestoreConstants.currentUser);
          //add UsersID to movie's key in the recommendationTrackMap
          event.recommendationsTrackMap[event.movieID].add(FirestoreConstants.currentUserId);

          if(!event.users.containsKey(FirestoreConstants.currentUserId)){
            //Map of <uid, usermodel> does not contain the current users model
            event.users[FirestoreConstants.currentUserId] = FirestoreConstants.currentUser;
          }
        }

        else
          {
         //Do nothing if the the user's vote has already been cast
        }
      } else {

        if(!event.users.containsKey(FirestoreConstants.currentUserId)){event.users[FirestoreConstants.currentUserId] = FirestoreConstants.currentUser;} //

        event.movieUserMap[event.movieID.toString()] = [FirestoreConstants.currentUser];

        final newMovieResponse = await getMovieDetail(MovieParams(movieID: event.movieID));
        if(newMovieResponse.isRight()){
          MovieDetailEntity newMovie = newMovieResponse.getOrElse(null);
          event.movies[event.movieID.toString()] = newMovie;
        }else{
          errorFlag=1; errorMessage= "Error occurred during adding new movie";
        }
        event.recommendationsTrackMap[event.movieID.toString()] = [event.currentUserID];
      }

      final response = await updateRecommendationsTrackMap(UpdateRecommendationsTrackMapParams(
          recommendationsTrackMap:  event.recommendationsTrackMap,
          postID: event.postID,
          ownerID: FirestoreConstants.currentUserId));
      if(errorFlag == 1) {
        yield AskForRecommendationsPostListError(errorMessage: errorMessage, appErrorType: appErrorType);
      } else{
        yield response.fold((l) => AskForRecommendationsPostListError(errorMessage: l.errorMessage, appErrorType: l.appErrorType),
    (r) => AskForRecommendationsPostListLoaded(
        users: event.users,
      recommendationsTrackMap: event.recommendationsTrackMap,
        movies: event.movies,
      postID: event.postID,
      movieUserMap: event.movieUserMap,
      ownerID: event.ownerID,
    ),);
      }
    }

    else if(event is RemoveRecommendationFromPostListEvent){ //movieID along with the current user's id
      // has to exist in the recommendation Movie TrackMap
      yield AskForRecommendationsPostListLoading();
      if(event.recommendationsTrackMap.keys.contains(event.movieID)){
        if(event.recommendationsTrackMap[event.movieID].contains(event.currentUserID)){
          event.recommendationsTrackMap[event.movieID].remove(FirestoreConstants.currentUserId);

          event.movieUserMap[event.movieID.toString()].removeWhere(
                  (element) => element.id == FirestoreConstants.currentUserId
          );

          if(event.recommendationsTrackMap[event.movieID].length==0){
            //Remove the entire recommendation if no voters are left in it
            event.recommendationsTrackMap.remove(event.movieID);
            event.users.remove(event.currentUserID);//Valid because one user can only vote for one movie
            event.movies.remove(event.movieID);
            event.movieUserMap.remove(event.movieID);
          }
          final response = await updateRecommendationsTrackMap(UpdateRecommendationsTrackMapParams(
              recommendationsTrackMap: event.recommendationsTrackMap,
              postID: event.postID,
              ownerID: event.ownerID));
          yield response.fold(
                (l) => AskForRecommendationsPostListError(errorMessage: l.errorMessage, appErrorType: l.appErrorType),
                (r) => AskForRecommendationsPostListLoaded(
                    users: event.users,
                    recommendationsTrackMap: event.recommendationsTrackMap,
                    movies: event.movies,
                    ownerID: event.ownerID,
                    postID: event.postID,
                    movieUserMap: event.movieUserMap),
          );
        }else {
          print("The recommendationTrackMap"
              "contains the movie ${event.movieID} but does"
              "not contain ${FirestoreConstants.currentUserId}'s vote");
        }
      }else{
        print("The recommendationTrack map does not contain the movie ${event.movieID}");
      }
    }

    } */

}

