import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

class WatchAlongPostModel {
  final UserModel user;
  final WatchAlong watchAlong;
  final MovieDetailEntity movieDetailEntity;

  WatchAlongPostModel(
      {@required this.movieDetailEntity,
      @required this.user,
      @required this.watchAlong});
}
