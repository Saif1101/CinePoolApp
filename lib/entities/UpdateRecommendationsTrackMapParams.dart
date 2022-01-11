import 'package:flutter/material.dart';

class UpdateRecommendationsTrackMapParams{
  final Map <String,List<String>> recommendationsTrackMap;
  final String ownerID;
  final String postID;

  UpdateRecommendationsTrackMapParams(
      {
        @required this.recommendationsTrackMap,
        @required this.ownerID,
        @required this.postID
      });


}