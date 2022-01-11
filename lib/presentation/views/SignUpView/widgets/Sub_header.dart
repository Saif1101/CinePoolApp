
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

class SubHeader extends StatelessWidget {
  final String subHeading;

  const SubHeader({Key key, this.subHeading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Please fill the form to continue.",
      style: GoogleFonts.poppins(
        color: ThemeColors.greyTextColor,
        fontSize: FontSize.medium,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
