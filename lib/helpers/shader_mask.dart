import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.centerLeft,
        colors: [Colors.lightBlueAccent, Colors.deepPurpleAccent],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}