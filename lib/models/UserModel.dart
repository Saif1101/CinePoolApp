import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;

  final Map<String, String> genres;
  final String timestamp;

  const UserModel({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.genres,
    this.timestamp
  });

  static UserModel copyWithEditProfile({UserModel currentUser, Map<String,String> genres, String username}){
    return UserModel(
      id: currentUser.id,
      email: currentUser.email,
      username: username?? currentUser.username,
      photoUrl: currentUser.photoUrl,
      displayName: currentUser.displayName,
      genres: genres ?? currentUser.genres,
      timestamp: currentUser.timestamp,
    );
  }

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromDocument(DocumentSnapshot doc){
    final invalidGenreMapFromFirestore = json.decode(json.encode(doc.data()['genres'])) as Map<String, dynamic>;

    Map<String, String> convertedGenreMap =
    invalidGenreMapFromFirestore.map((key, value) => MapEntry(key, value?.toString()));



    return UserModel(
        id: doc.data()['id'],
        email: doc.data()['email'],
        username: doc.data()['username'],
        photoUrl: doc.data()['photoUrl'],
        displayName: doc.data()['displayName'],
        genres: convertedGenreMap,
      timestamp: doc.data()['timestamp'],
    );
  }

  /*Map<String, dynamic> toJson() =>
      {
        "id": id,
        "email": email,
        "username": username,
        "photoUrl": photoUrl,
        "displayName": displayName,
        "genres": genres,
        "timestamp": timestamp,
      };*/



  @override
  String toString() {

    return("User details-> ID: ${this.id}, Username: ${this.username}, Genres:${this.genres},"
        "displayName: ${this.displayName}, e-mail: ${this.email},  photoURL: ${this.photoUrl}, "
        "timestamp: ${this.timestamp}");
  }

  @override

  List<Object> get props => [email,displayName,id,genres,photoUrl,timestamp];





}

