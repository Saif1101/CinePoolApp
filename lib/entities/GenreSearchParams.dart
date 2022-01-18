import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GenreSearchParams extends Equatable{
  final String genreID;

  GenreSearchParams({@required this.genreID});


  @override
  List<Object> get props => [genreID];
}