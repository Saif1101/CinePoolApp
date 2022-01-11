import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:transparent_image/transparent_image.dart';

class AvatarCircle extends StatefulWidget {
  const AvatarCircle({
    Key key,
    @required this.user,
    this.size = 48,
    @required this.nameLabelColor,
    @required this.backgroundColor,
  }) : super(key: key);

  final UserModel user;
  final double size;
  final Color nameLabelColor;
  final Color backgroundColor;

  @override
  _AvatarCircleState createState() => _AvatarCircleState();
}

class _AvatarCircleState extends State<AvatarCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.user.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.nameLabelColor,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.user.photoUrl,
            fadeInDuration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}