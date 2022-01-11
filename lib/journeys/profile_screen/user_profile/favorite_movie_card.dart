import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';

import 'package:socialentertainmentclub/journeys/home/movie_detail/movie_detail_arguments.dart';


class FavoriteMovieCardWidget extends StatelessWidget {
  final MovieEntity movie;

  const FavoriteMovieCardWidget({Key key, @required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(RouteList.movieDetail,arguments: MovieDetailArguments(movieID: movie.id,
            userID: FirestoreConstants.currentUserId));
      },
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
