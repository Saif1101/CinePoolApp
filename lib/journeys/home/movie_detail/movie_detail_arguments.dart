//take movieID from the carousels to the movieDetailScreen and make an API call
import 'package:flutter/material.dart';

class MovieDetailArguments{
  final int movieID;
  final String userID;

  const MovieDetailArguments({@required this.movieID, @required this.userID});

}