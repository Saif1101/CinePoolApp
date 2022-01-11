import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helpers/font_size.dart';
import '../../../../helpers/theme_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String iconPath;
  final Function() onTap;
  const MainButton({
    Key key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,

        decoration: BoxDecoration(
          color: backgroundColor == null
              ? ThemeColors.primaryColor
              : backgroundColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconPath == null
                  ? Container()
                  : Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image(
                  image: AssetImage(iconPath),
                  height: 30,
                ),
              ),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: textColor == null
                      ? ThemeColors.whiteTextColor
                      : textColor,
                  fontSize: FontSize.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}