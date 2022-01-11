import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

class Header extends StatelessWidget {
  final String heading;

  const Header({Key key, this.heading}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      "$heading",
      style: GoogleFonts.poppins(
        color: ThemeColors.whiteTextColor,
        fontSize: FontSize.xxLarge,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}