import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';

import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';


class MovieDetailAppBar extends StatelessWidget {

  const MovieDetailAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: Sizes.dimen_12.h,
          ),
        ),
      ],
    );
  }
}