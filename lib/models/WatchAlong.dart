import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/models/Post.dart';

class WatchAlong extends Post{

  final String watchAlongID;
  final String ownerID;
  final String title;
  final String location;
  final String movieID;
  final DateTime scheduledTime;

  WatchAlong({
    this.watchAlongID,
    @required this.location,
    @required this.ownerID,
    @required this.title,
    @required this.movieID,
    @required this.scheduledTime});

  @override
  List<Object> get props => [title,movieID,scheduledTime];

  factory WatchAlong.fromDocument(DocumentSnapshot doc){
    return WatchAlong(
      location: doc['location'],
      watchAlongID: doc['watchAlongID'],
      scheduledTime: doc['scheduledTime'].toDate(),
        title: doc['title'],
        ownerID: doc['ownerID'],
        movieID: doc['movieID'],
    );
  }

  @override
  String toString() {
    return 'Title: $title, Location: $location';
  }

}