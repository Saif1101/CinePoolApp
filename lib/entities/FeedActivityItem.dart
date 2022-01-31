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
      actorUserID: doc.data()['actorUserID'],
      type: doc.data()['type'],
      postTitle: doc.data()['postTitle'],
      postID: doc.data()['postID'],
      userPhotoURL: doc.data()['userPhotoURL'],
      username:doc.data()['username'],
      postOwnerID: doc.data()['postOwnerID'],
      timestamp: doc.data()['timestamp'].toDate()
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
      type: doc.data()['type'],
      actorUserID: doc.data()['actorUserID'],
      userPhotoURL: doc.data()['userPhotoURL'],
      username:doc.data()['username'],
      followedUserID: doc.data()['followedUserID'],
      timestamp: doc.data()['timestamp'].toDate(), 
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
      type: doc.data()['type'],
      username: doc.data()['username'],
      userPhotoURL: doc.data()['userPhotoURL'],
      postOwnerID: doc.data()['postOwnerID'],
      postTitle: doc.data()['postTitle'],
      movieID: doc.data()['movieID'], 
      timestamp: doc.data()['timestamp'].toDate(), 
      actorUserID: doc.data()['actorUserID'], 
      postID: doc.data()['postID'],
    );
  }

}

