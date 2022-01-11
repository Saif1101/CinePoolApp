import 'package:flutter/material.dart';

class CastPollVoteParams {
  final String postID;
  final String ownerID;
  final Map <String,int> pollOptionsMap; //{movieID, votes} // The movie ID can be used to fetch data about the movie
  final Map<String, int> votersMap;

  CastPollVoteParams({
    @required  this.postID,
    @required this.ownerID,
    @required this.pollOptionsMap,
    @required this.votersMap
  }); //{userID, movieID}
}