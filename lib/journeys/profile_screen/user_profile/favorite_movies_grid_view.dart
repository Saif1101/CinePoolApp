import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/entities/favorited_movie.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/favorite_movie_card.dart';


class FavoriteMoviesGridView extends StatelessWidget {
  final List<FavoritedMovie> movies;

  const FavoriteMoviesGridView({Key key,@required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_2.w),
      child: MasonryGridView.count(
        physics: ScrollPhysics(),
        mainAxisSpacing: Sizes.dimen_4.h,
        shrinkWrap: true,
        itemCount: movies.length,
        crossAxisCount: 3,
          crossAxisSpacing: Sizes.dimen_8.w,
        itemBuilder: (context,index){
            return FavoriteMovieCardWidget(
            movie:movies[index])
            ;
        },
      ),
    );
  }
}


