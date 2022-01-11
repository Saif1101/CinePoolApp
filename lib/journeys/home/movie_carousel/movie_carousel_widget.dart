import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/presentation/widgets/separator.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';

import 'movie_backdrop_widget.dart';
import 'movie_data_widget.dart';
import 'movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget{
final List<MovieEntity> movies;
final int defaultIndex;

  const MovieCarouselWidget({Key key, this.movies, this.defaultIndex}) : assert(defaultIndex>=0,'Default index cannot be less than 0');
@override
Widget build(BuildContext context) {
  return Stack(

    children: [
      MovieBackdropWidget(),
      Column(
        children: [
          SizedBox(
            height: ScreenUtil.screenHeight*0.01,
          ),//TO-DO should make it so that it adjusts dynamically
          MoviePageView(
            movies: movies,
            initialPage: defaultIndex,
          ),
          MovieDataWidget(),
          Separator(height: Sizes.dimen_1.h,
              width: Sizes.dimen_80.w,),

        ],
      ),
    ],
  );
}
}