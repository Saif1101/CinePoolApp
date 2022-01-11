import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';


import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';


class SearchUserCard extends StatelessWidget {
  final UserModel user;

  const SearchUserCard({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(RouteList.profilePage,arguments:user);
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizes.dimen_8.w),
            child: CircleAvatar(
              radius: Sizes.dimen_40.w,
              backgroundImage: user.photoUrl!=null?CachedNetworkImageProvider(
                user.photoUrl,
              ):AssetImage('assets/images/FreeVector-Sync-Slate.jpg'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  user.username,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: Sizes.dimen_8.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}