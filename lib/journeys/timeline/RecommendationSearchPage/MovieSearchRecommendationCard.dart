

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';

import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';

class MovieSearchRecommendationCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieSearchRecommendationCard({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(Sizes.dimen_8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_4.w),
            child: movie.posterPath!=null?CachedNetworkImage(
              imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
              width: Sizes.dimen_80.w,
            ):Image.asset('assets/images/FreeVector-Sync-Slate.jpg', width: 80,),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                movie.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: Sizes.dimen_8.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.5),
                child: Text(
                  movie.releaseDate ??'',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                    fontSize: Sizes.dimen_5.h,
                  ),
                ),
              ),
              Text(
                movie.overview ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.dimen_6.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}