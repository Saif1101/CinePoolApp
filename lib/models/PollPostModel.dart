import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/models/Post.dart';

class PollPostModel extends Post{
  final String postID;
  final String type;
  final String ownerID;
  final String title;
  final Map <String,int> pollOptionsMap; //{movieID, votes} // The movie ID can be used to fetch data about the movie
  final Map<String, int> votersMap; //{userID, movieID}


  PollPostModel({
    @required this.votersMap,
    this.postID,
      @required this.type,
      @required this.ownerID,
      @required this.title,
      @required this.pollOptionsMap});

  factory PollPostModel.fromDocument(DocumentSnapshot doc){

    final invalidPollOptionsFromFirestore = json.decode(json.encode(doc['pollOptionsMap'])) as Map<String, dynamic>;
    final invalidVotersMapFromFirestore = json.decode(json.encode(doc['votersMap'])) as Map<String, dynamic>;

    Map<String, int> pollOptionsMap =
    invalidPollOptionsFromFirestore.map((key, value) => MapEntry(key, value?.toInt()));

    Map <String,int> votersMap =
    invalidVotersMapFromFirestore.map((key, value) => MapEntry(key, value?.toInt()));

    return PollPostModel(
        postID: doc['postID'],
        title: doc['title'],
        pollOptionsMap: pollOptionsMap,
        type: doc['type'],
        ownerID: doc['ownerID'],
        votersMap: votersMap,
    );
  }



  @override
  List<Object> get props => [type, postID, type, ownerID, title,pollOptionsMap, votersMap,];

  @override
  bool get stringify => true;
}