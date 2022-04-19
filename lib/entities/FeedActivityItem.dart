import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class FeedActivityItem {
  final String type;
  final String postID;
  final String postOwnerID; 
  final String actorUserID;
  final String movieID; 


  FeedActivityItem(this.type, {this.actorUserID, this.postID, this.postOwnerID, this.movieID});
}

class VoteRecommendActivity extends FeedActivityItem{

  final String type; 

  final String actorUserID; 
  final String postTitle; 
  final String postID; 
  final String username; 
  final String userPhotoURL;
  final String postOwnerID; //will be adding to postOwners feed
  final DateTime timestamp;

  VoteRecommendActivity({
  @required this.actorUserID, 
  @required this.username, 
  @required this.type, 
  @required this.postTitle,
  @required this.postID, 
  @required this.userPhotoURL, 
  @required this.postOwnerID, 
  @required this.timestamp}) : super(type, postID: postID, postOwnerID: postOwnerID, actorUserID: actorUserID);
  


factory VoteRecommendActivity.fromDocument(DocumentSnapshot doc){
  

    return VoteRecommendActivity(
      actorUserID: doc['actorUserID'],
      type: doc['type'],
      postTitle: doc['postTitle'],
      postID: doc['postID'],
      userPhotoURL: doc['userPhotoURL'],
      username:doc['username'],
      postOwnerID: doc['postOwnerID'],
      timestamp: doc['timestamp'].toDate()
    );
  }
}

class NewFollowerActivity extends FeedActivityItem{
    final String type; 
    final String actorUserID;
    final String userPhotoURL; 
    final String username; 
    final String followedUserID;
    final DateTime timestamp;

    NewFollowerActivity({
      @required this.actorUserID,
      @required this.type, 
      @required this.userPhotoURL, 
      @required this.username,
      @required this.followedUserID,
      @required this.timestamp
      }) : super(type); 
    
  factory NewFollowerActivity.fromDocument(DocumentSnapshot doc){

    return NewFollowerActivity(
      type: doc['type'],
      actorUserID: doc['actorUserID'],
      userPhotoURL: doc['userPhotoURL'],
      username:doc['username'],
      followedUserID: doc['followedUserID'],
      timestamp: doc['timestamp'].toDate(), 
    );
  }
}

class OptedInToWatchAlongActivity extends FeedActivityItem{
  final String type; 
  final String username; 
  final String userPhotoURL; 
  final String postOwnerID; 
  final String postTitle; 
  final String movieID; 
  final DateTime timestamp; 
  final String postID;
  final String actorUserID;

  OptedInToWatchAlongActivity(
    {
    @required this.actorUserID, 
    @required this.postID,
    @required this.type, 
    @required this.username, 
    @required this.userPhotoURL,
    @required this.postOwnerID,
    @required this.postTitle, 
    @required this.movieID,
    @required this.timestamp}
    ) : super(type, movieID: movieID, postOwnerID: postOwnerID, actorUserID: actorUserID); 
  

  factory OptedInToWatchAlongActivity.fromDocument(DocumentSnapshot doc) {

    return OptedInToWatchAlongActivity(
      type: doc['type'],
      username: doc['username'],
      userPhotoURL: doc['userPhotoURL'],
      postOwnerID: doc['postOwnerID'],
      postTitle: doc['postTitle'],
      movieID: doc['movieID'], 
      timestamp: doc['timestamp'].toDate(), 
      actorUserID: doc['actorUserID'], 
      postID: doc['postID'],
    );
  }

}

