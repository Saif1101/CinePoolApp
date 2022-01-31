import 'package:flutter/material.dart';

class DeleteActivityFromFeedParams{
  final String feedOwnerID; 
  final String activityID;

  DeleteActivityFromFeedParams({
    @required this.feedOwnerID, 
    @required this.activityID
  });


}