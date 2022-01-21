import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int minLength;
  final int maxLength;
  final Color hintTextColor;
  

  const CustomTextField({Key key, this.hintTextColor, this.maxLength, this.minLength, @required this.hintText,
    @ required this.controller,}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return TextFormField(
      maxLines: null,
      maxLength: maxLength,
      controller: this.controller,
      validator: (value) {
        if (this.controller.text.isEmpty || this.controller.text.length<minLength) {
          return "This field can't be less than ${minLength.toString()} characters";
        } else if(this.controller.text.length>maxLength){
          return "This field can't have more than ${maxLength.toString()} characters";
        }
      },
      onSaved: (value){
        controller.text=value;
      },
      style: GoogleFonts.poppins(
        color: ThemeColors.whiteTextColor,
      ),
      cursorColor: ThemeColors.primaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: ThemeColors.textFieldBgColor,
        filled: true,
        hintText: "$hintText",
        counterStyle: TextStyle(color: Colors.white),
        hintStyle: GoogleFonts.poppins(
          color: hintTextColor??ThemeColors.textFieldHintColor,
          fontSize: FontSize.medium,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
    );
  }
}
