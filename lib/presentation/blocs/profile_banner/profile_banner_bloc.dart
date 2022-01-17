import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_FollowersAndFollowing.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/check_IfFollowing.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_Followers.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_Following.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/remove_Follower.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';

part 'profile_banner_event.dart';
part 'profile_banner_state.dart';

class ProfileBannerBloc extends Bloc<ProfileBannerEvent, ProfileBannerState> {
  final AddFollowersAndFollowing addFollowersAndFollowing;
  final RemoveFollower removeFollower;
  final GetFollowing getFollowing;
  final GetFollowers getFollowers;
  final CheckIfFollowing checkIfFollowing;
  String profileUserID;

  ProfileBannerBloc({@required this.addFollowersAndFollowing,
      @required this.removeFollower,
      @required this.getFollowing,
    @required this.getFollowers,
    @required this.checkIfFollowing}) : super(ProfileBannerInitial())
    {
       on<ToggleFollowUserEvent>(_onToggleFollowUserEvent);
      on<LoadProfileBannerEvent>(_onLoadProfileBannerEvent);
      on<UnfollowUserEvent>(_onUnfollowUserEvent);
      on<ProfileBannerEvent>(fetchFollowedStatusAndLoad);

      
    }
  
  Future<void> _onToggleFollowUserEvent(
    ToggleFollowUserEvent event, 
    Emitter<ProfileBannerState> emit,
  ) async {
     if(event.isFollowing){
        await removeFollower(this.profileUserID);
      } else{
        await addFollowersAndFollowing(this.profileUserID);
      }
      fetchFollowedStatusAndLoad();
  }

  void _onLoadProfileBannerEvent(
    LoadProfileBannerEvent event, 
    Emitter<ProfileBannerState> emit,
  ){
      emit(ProfileBannerLoading());
      this.profileUserID = event.userID;
      fetchFollowedStatusAndLoad();
  }

  Future<void> _onUnfollowUserEvent(
    UnfollowUserEvent event, 
    Emitter<ProfileBannerState> emit,
  ) async {
      await removeFollower(this.profileUserID);
  }

  void fetchFollowedStatusAndLoad(
  ) async {
    
    Either<AppError, int> followerCount = await getFollowers(this.profileUserID);
    if(followerCount.isRight()){
      Either<AppError, int> followingCount = await getFollowing(this.profileUserID);
      if(followingCount.isRight()){
        Either<AppError,bool> checkFollow = await checkIfFollowing(this.profileUserID);
        if(checkFollow.isRight()){
           emit(ProfileBannerFinalLoaded(
            followerCount:  followerCount.getOrElse(null).toString(),
              followingCount: followingCount.getOrElse(null).toString(),
              isFollowed:  checkFollow.getOrElse(null))
            );
        } else{
          emit (ProfileBannerError());
        }
      } else{
        emit(ProfileBannerError());
      }
    } else{
      emit(ProfileBannerError());
    }
  }
}

  
  /* LEGACY mapEventToState
  @override
  Stream<ProfileBannerState> mapEventToState(ProfileBannerEvent event)
  async* {
    if(event is ToggleFollowUserEvent){
      if(event.isFollowing){
        await removeFollower(this.profileUserID);
      } else{
        await addFollowersAndFollowing(this.profileUserID);
      }
      yield* _fetchFollowedStatusAndLoad();
    } else if (event is LoadProfileBannerEvent){
      yield ProfileBannerLoading();
      this.profileUserID = event.userID;
      yield* _fetchFollowedStatusAndLoad();
    } else if(event is UnfollowUserEvent){
      await removeFollower(this.profileUserID);
      yield* _fetchFollowedStatusAndLoad();
    }
  }
    
  }

  /*emit(ProfileBannerLoading());
    Either<AppError, int> followerCount = await getFollowers(this.profileUserID);
    if(followerCount.isRight()){
      Either<AppError, int> followingCount = await getFollowing(this.profileUserID);
      if(followingCount.isRight()){
        Either<AppError,bool> checkFollow = await checkIfFollowing(this.profileUserID);
        if(checkFollow.isRight()){
           emit(ProfileBannerFinalLoaded(
            followerCount:  followerCount.getOrElse(null).toString(),
              followingCount: followingCount.getOrElse(null).toString(),
              isFollowed:  checkFollow.getOrElse(null))
            );
        } else{
          emit (ProfileBannerError());
        }
      } else{
        emit(ProfileBannerError());
      }
    } else{
      emit(ProfileBannerError());
    }*/
  
  /* LEGACY mapEventToState
  @override
  Stream<ProfileBannerState> mapEventToState(ProfileBannerEvent event)
  async* {
    if(event is ToggleFollowUserEvent){
      if(event.isFollowing){
        await removeFollower(this.profileUserID);
      } else{
        await addFollowersAndFollowing(this.profileUserID);
      }
      yield* _fetchFollowedStatusAndLoad();
    } else if (event is LoadProfileBannerEvent){
      yield ProfileBannerLoading();
      this.profileUserID = event.userID;
      yield* _fetchFollowedStatusAndLoad();
    } else if(event is UnfollowUserEvent){
      await removeFollower(this.profileUserID);
      yield* _fetchFollowedStatusAndLoad();
    }
  }

*/
*/
