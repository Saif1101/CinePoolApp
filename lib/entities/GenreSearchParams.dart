import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GenreSearchParams extends Equatable{
  final String genreID;

  GenreSearchParams({@required this.genreID});


  @override
  // TODO: implement props
  List<Object> get props => [genreID];
}