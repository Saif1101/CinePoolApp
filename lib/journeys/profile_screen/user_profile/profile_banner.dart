
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';

import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/RoundedBorderActionButton.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/profile_genre_tags_grid.dart';





import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/presentation/blocs/profile_banner/profile_banner_bloc.dart';


class ProfileBanner extends StatelessWidget {
  final UserModel user;
  final bool isFollowed;
  final String followerCount;
  final String followingCount;
  bool isOwner;



  ProfileBanner({@required this.user, @required this.isFollowed, this.followerCount, this.followingCount}){
    isOwner = FirestoreConstants.currentUserId == user.id;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:8.0,left:2.0, right:2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:Color(0xFF221e38),
            ),
            //Color(0xFF161522), //Color(0xFF383454),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(Sizes.dimen_18.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: Sizes.dimen_56.w,
                        backgroundImage: CachedNetworkImageProvider(user.photoUrl) ,
                      ),
                      SizedBox(
                        height: Sizes.dimen_6.h,
                      ),
                      Text(
                        '${user.username}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: Sizes.dimen_12.h,
                          fontWeight: FontWeight.w300,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: Sizes.dimen_5.h,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Followers',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                              '${followerCount.toString()}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        width: 1,
                        height: 22,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Following',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                              '${followingCount.toString()}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        width: 1,
                        height: 22,
                      ),
                      !isOwner?
                      !isFollowed?
                      Button(text:'Follow', onTap: (){BlocProvider.of<ProfileBannerBloc>(context).
                      add(ToggleFollowUserEvent(isFollowing:isFollowed, userID: user.id));}):
                      Button(text:'Unfollow', onTap: (){BlocProvider.of<ProfileBannerBloc>(context)
                          .add(ToggleFollowUserEvent(isFollowing: isFollowed, userID: user.id));})
                          : RadiantGradientMask(child: Button(text: 'Edit', onTap: (){
                        Navigator.of(context).pushNamed(RouteList.editProfile);
                      }
                      ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          RadiantGradientMask(
              child: GenreTagsHorizontalScroll(
                genres: user.genres.values.toList(),
                leftTitle: 'Genres',
              ),
          ),

        ],
      ),
    );
  }
}
