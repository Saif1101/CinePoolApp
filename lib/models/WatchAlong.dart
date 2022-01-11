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
      location: doc.data()['location'],
      watchAlongID: doc.data()['watchAlongID'],
      scheduledTime: doc.data()['scheduledTime'].toDate(),
        title: doc.data()['title'],
        ownerID: doc.data()['ownerID'],
        movieID: doc.data()['movieID'],
    );
  }

  @override
  String toString() {
    return 'Title: $title, Location: $location';
  }

}