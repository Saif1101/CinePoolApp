import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

class MovieBackdropWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:7.5,),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(Sizes.dimen_32.w),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                child: BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
                  builder: (context, state) {
                    if (state is MovieBackdropChanged) {
                      return CachedNetworkImage(
                        imageUrl:
                        '${ApiConstants.BASE_IMAGE_URL}${state.movie.backdropPath}',
                        fit: BoxFit.fitHeight,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: ScreenUtil.screenWidth,
                  height: 1,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}