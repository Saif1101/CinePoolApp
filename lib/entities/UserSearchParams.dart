import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserSearchParams extends Equatable {
  final String searchTerm;

  UserSearchParams({@required this.searchTerm});

  @override

  List<Object> get props => [searchTerm];

}