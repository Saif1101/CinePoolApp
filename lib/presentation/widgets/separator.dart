import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';


class Separator extends StatelessWidget {
  final double width;
  final double height;

  const Separator({Key key, @required this.width, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(
        top: Sizes.dimen_1.h,
        bottom: Sizes.dimen_6.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_1.h)),
        gradient: LinearGradient(
          colors: [
            ThemeColors.primaryColor,
            Colors.pinkAccent,
          ],
        ),
      ),
    );
  }
}