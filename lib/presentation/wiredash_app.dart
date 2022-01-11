import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:wiredash/wiredash.dart';


class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;

  const WiredashApp({Key key,
    @required this.navigatorKey,
    @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'socialentertainmentclub-shm2tmj',
      secret: 'MhvpJKJlMSHITP_se7mjWZkgVo07l3Vf',
      navigatorKey: navigatorKey,
      child: child,
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: ThemeColors.royalBlue,
        secondaryColor: ThemeColors.violet,
        secondaryBackgroundColor: ThemeColors.vulcan,
        dividerColor: ThemeColors.vulcan
      ),
    );
  }
}
