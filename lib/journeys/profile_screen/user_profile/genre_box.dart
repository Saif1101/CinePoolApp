import 'package:flutter/material.dart';

import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';

class GenreBox extends StatelessWidget {
  final String genre;

  const GenreBox({Key key, @required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '$genre',
          style: TextStyle(
            fontSize: Sizes.dimen_5.h,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
