import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/home/explore_screen.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/profile_screen.dart';
import 'package:socialentertainmentclub/journeys/search/searchPage.dart';

import 'package:socialentertainmentclub/journeys/timeline/TimelinePage.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/presentation/views/AboutView/AboutPage.dart';
import 'package:wiredash/wiredash.dart';

class MainView extends StatefulWidget {
  final UserModel currentUser;

  const MainView({Key key, this.currentUser}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int pageIndex = 0;
  PageController pageController = PageController();

  onPageChanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  navigationOnTap(int index){
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        children: <Widget>[
          ProfileScreen(user: widget.currentUser),
          ExploreScreen(currentUser: widget.currentUser),
          SearchPage(),
          TimelinePage(),
          AboutPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: ThemeColors.vulcan,
        buttonBackgroundColor: Colors.white,
        backgroundColor: ThemeColors.vulcan,
        items: <Widget>[
          RadiantGradientMask(
            child: Icon(Icons.person,
                color: Colors.white,
                size: 25),
          ),
          RadiantGradientMask(
            child: Icon(Icons.track_changes,
                color: Colors.white,
                size: 25),
          ),
          RadiantGradientMask(
            child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25),
          ),
          RadiantGradientMask(
            child: Icon(
                Icons.list,
                color: Colors.white,
                size: 25),
          ),
          RadiantGradientMask(
            child: Icon(Icons.build,
                color: Colors.white,
                size: 25),
          ),
        ],
        onTap: (index) {
          //Handle button tap
          if(index!=4){
            navigationOnTap(index);
          }
          else{
            Wiredash.of(context).show();
          }
        },
        height: 45,
      ),
    );
  }
}
