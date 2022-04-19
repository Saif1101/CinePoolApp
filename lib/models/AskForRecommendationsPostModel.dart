

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/models/Post.dart';

class AskForRecommendationsPostModel extends Post{
  final String postID;
  final String type;
  final String ownerID;
  final String title;
  final Map<String, List<String>> recommendationsTrackMap; //{movieID, ListOfUsers who recommended this} //
  // Map users to the recommendations they provided
  final List<String> preferredGenres; //[genreNames]

  AskForRecommendationsPostModel({
    @required this.preferredGenres,
    @required this.recommendationsTrackMap,
    this.postID,
    @required this.type,
    @required this.ownerID,
    @required this.title,});

  factory AskForRecommendationsPostModel.fromDocument(DocumentSnapshot doc){
    final invalidRecommendationTrackMapFromFirestore = json.decode(json.encode(doc['recommendationsTrackMap'])) as Map<String, dynamic>;

    Map<String, List<String>> recommendationsTrackMap =
    invalidRecommendationTrackMapFromFirestore.map((key, value) => MapEntry(key,List<String>.from(value)));

    List<String> preferredGenresList = List<String>.from(doc['preferredGenres']);

    return AskForRecommendationsPostModel(
      postID: doc['postID'],
      title: doc['title'],
      type: doc['type'],
      ownerID: doc['ownerID'],
      recommendationsTrackMap: recommendationsTrackMap,
      preferredGenres: preferredGenresList,
    );
  }



  @override
  List<Object> get props => [type, postID, type, ownerID, title, recommendationsTrackMap, preferredGenres];

}

