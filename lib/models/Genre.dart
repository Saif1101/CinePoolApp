
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class Genre extends Equatable {
  int id;
  String name;

  Genre({ @required this.id,
    @required this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
 
  List<Object> get props => [id,name];

  @override
  bool get stringify => true;
}