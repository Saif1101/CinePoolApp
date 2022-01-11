import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class CastEntity extends Equatable {
  final String creditID;
  final String name;
  final String posterPath;
  final String character;

  CastEntity({
    @required this.creditID,
    @required this.name,
    @required this.posterPath,
    @required this.character,
  });

  @override
  List<Object> get props => [creditID];
}