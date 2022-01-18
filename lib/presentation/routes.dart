import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/movie_detail_screen.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/edit_profile/edit_profile.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/my_pollPosts/my_pollposts_page.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/my_recommendationPosts/my_recommendationposts_page.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/my_watchalongs/my_watchalongs_page.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/profile_screen.dart';
import 'package:socialentertainmentclub/journeys/timeline/CreateAskForRecommendationsPage/CreateAskForRecommendationsPostPage.dart';
import 'package:socialentertainmentclub/journeys/timeline/CreatePollPostPage/CreatePollPostPage.dart';
import 'package:socialentertainmentclub/journeys/timeline/RecommendationSearchPage/AddRecommendationPage.dart';

import 'package:socialentertainmentclub/presentation/views/AboutView/AboutPage.dart';
import 'package:socialentertainmentclub/presentation/views/HomeView/HomeView.dart';
import 'package:socialentertainmentclub/presentation/views/LoginView/LoginSplashScreen.dart';
import 'package:socialentertainmentclub/presentation/views/MainView/MainView.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/NewUserSignUpSplashScreen.dart';

class Routes{
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) =>{
    RouteList.initial:(context) => HomeView(),
    RouteList.movieDetail:(context) => MovieDetailScreen(movieDetailArguments: setting.arguments,),
    RouteList.loginPage:(context)=> LoginSplashScreen(),
    RouteList.signUpPage:(context) => NewUserSignUp(newUserSignUpParams: setting.arguments),
    RouteList.editProfile:(context)=> EditProfile(),

    RouteList.myWatchAlongs:(context)=> MyWatchAlongsPage(),
    RouteList.myRecommendationPosts:(context)=> MyRecommendationPosts(),
    RouteList.myPollPosts:(context)=> MyPollPosts(),

    RouteList.createPollPostPage:(context)=> CreatePollPostPage(),

    RouteList.addRecommendationPage:(context)=> AddRecommendationPage(navigateRecommendationsPollParams: setting.arguments),

    RouteList.addToPollOptions:(context)=> AddRecommendationPage(navigateRecommendationsPollParams: setting.arguments),

    RouteList.aboutPage:(context)=>AboutPage(),

    RouteList.mainPage:(context)=>MainView(currentUser: setting.arguments,),
    RouteList.profilePage:(context)=> ProfileScreen(user: setting.arguments),
    RouteList.createAskForRecommendationsPostPage: (context) => CreateAskForRecommendationsPostPage(),

  };
}