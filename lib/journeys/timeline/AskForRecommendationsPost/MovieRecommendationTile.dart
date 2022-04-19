
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/journeys/timeline/FacePile.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

class MovieRecommendationTile extends StatelessWidget {
  final List<UserModel> users;
  final MovieDetailEntity movie;
  final Function onTap;

 MovieRecommendationTile({
    @required this.movie,
   @required this.onTap,
    @required this.users
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: CircleAvatar(
        backgroundImage: movie.posterPath!=null?CachedNetworkImageProvider(
          '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
          maxWidth: (ScreenUtil.screenWidth~/4),
        ):AssetImage('assets/images/FreeVector-Sync-Slate.jpg'),
      ),
      title: Text(
        movie.title,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500

        ),
      ),
      trailing: LayoutBuilder(

        builder:(context,constraints)=>Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: constraints.maxWidth/3.5,
              child: FacePile(users: users),
            ),
            users.contains(FirestoreConstants.currentUser)?
            IconButton(
              icon: Icon(Icons.close,
                color: Colors.blueGrey,),
              onPressed: onTap,
            ):SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
