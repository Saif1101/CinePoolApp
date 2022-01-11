part of 'profile_banner_bloc.dart';

abstract class ProfileBannerEvent extends Equatable {
  const ProfileBannerEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileBannerEvent extends ProfileBannerEvent{
  final String userID;

  LoadProfileBannerEvent({@required this.userID});

  @override
  List<Object> get props => [userID];
}

class UnfollowUserEvent extends ProfileBannerEvent{
  final String userID;

  UnfollowUserEvent({@required this.userID});

  @override

  List<Object> get props => [userID];

}

class FollowUserEvent extends ProfileBannerEvent{
  final String userID;

  FollowUserEvent({@required this.userID});

  @override
  List<Object> get props => [userID];
}

class ToggleFollowUserEvent extends ProfileBannerEvent{
  final String userID;
  final bool isFollowing;

  ToggleFollowUserEvent({@required this.isFollowing,
    @required this.userID});

  @override
  List<Object> get props => [userID, isFollowing];
}

class CheckIfFollowingEvent extends ProfileBannerEvent{
  final String userID;

  CheckIfFollowingEvent({@required this.userID});

  @override
  List<Object> get props => [userID];

}

