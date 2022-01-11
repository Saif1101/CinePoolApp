import 'package:flutter/material.dart';

import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';

import 'genre_box.dart';

class GenreTagsHorizontalScroll extends StatelessWidget {
  final List<String> genres;
  final String leftTitle;
  final Color scrollBgColor;
  final Color titleColor;
  final FontWeight leftTitleWeight;


  const GenreTagsHorizontalScroll(
      {Key key,
        this.leftTitleWeight,
        this.titleColor,
        this.scrollBgColor,
      @required this.genres,
      @required this.leftTitle,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scrollBgColor??Colors.white.withOpacity(0.84),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: Sizes.dimen_16.h,
        child: Container(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: genres.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: Sizes.dimen_4.h,
              crossAxisCount: 1,
              crossAxisSpacing: Sizes.dimen_8.w,
              childAspectRatio: 0.3,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    this.leftTitle,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      //
                      fontWeight: leftTitleWeight??FontWeight.bold,
                      color: titleColor??Colors.black,
                    ),
                  ),
                );
              } else {
                return GenreBox(genre: genres[index - 1]);
              }
            },
          ),
        ),
      ),
    );
  }
}
