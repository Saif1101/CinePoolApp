import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/movie_detail_arguments.dart';



class MovieCardWidget extends StatelessWidget {
  final int movieID;
  final String posterPath;
  const MovieCardWidget({Key key,
    @required this.movieID,
    @required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>{
        Navigator.of(context).pushNamed(RouteList.movieDetail,arguments: MovieDetailArguments(movieID: movieID, userID: FirestoreConstants.currentUserId))
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
