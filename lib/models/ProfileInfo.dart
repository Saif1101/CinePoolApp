import 'package:flutter/material.dart';

class ProfileInfo{
  final String followersCount; 
  final String followingCount; 
  final bool isFollowing;

  ProfileInfo({
    @required this.followersCount,
   @required this.followingCount,
    @required this.isFollowing
    }); 
  
}