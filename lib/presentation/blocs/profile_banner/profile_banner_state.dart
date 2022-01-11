part of 'profile_banner_bloc.dart';

abstract class ProfileBannerState extends Equatable {
  const ProfileBannerState();

  @override
  List<Object> get props => [];
}

class ProfileBannerInitial extends ProfileBannerState {}

class ProfileBannerFollowersLoaded extends ProfileBannerState{
  final bool isFollowed;
  final String followerCount;

  ProfileBannerFollowersLoaded({@required this.isFollowed,@required this.followerCount});

  @override
  List<Object> get props => [isFollowed,followerCount];

}

class ProfileBannerLoading extends ProfileBannerState{
}

class ProfileBannerFinalLoaded extends ProfileBannerState{
  final bool isFollowed;
  final String followerCount;
  final String followingCount;


  ProfileBannerFinalLoaded({@required this.followerCount, @required this.followingCount,@required this.isFollowed});

  @override
  List<Object> get props => [isFollowed];
}

class ProfileBannerError extends ProfileBannerState{}

class IsFollowed extends ProfileBannerState{
  final bool isFollowed;

  IsFollowed(this.isFollowed);

  @override

  List<Object> get props => [isFollowed];
}