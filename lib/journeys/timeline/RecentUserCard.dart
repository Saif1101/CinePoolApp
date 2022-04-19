import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/genre_box.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';

class RecentUserCard extends StatelessWidget {
  final UserModel user;

  const RecentUserCard({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(RouteList.profilePage,arguments:user);
      },
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_24.w),
              child: CircleAvatar(
                radius: Sizes.dimen_24.w,
                backgroundImage: user.photoUrl!=null?CachedNetworkImageProvider(
                  user.photoUrl,
                ):AssetImage('assets/images/FreeVector-Sync-Slate.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                user.username,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: Sizes.dimen_8.h,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  height: 80.0,
                 
                  child: GridView.builder(
                    
                    shrinkWrap: true,
                    itemCount: user.genres.length,
                     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                       childAspectRatio: 3,
                       
                        maxCrossAxisExtent: 125), 
                     itemBuilder: (BuildContext context, int index) {  
                       return GenreBox(genre: user.genres.values.toList()[index]);
                     },
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}