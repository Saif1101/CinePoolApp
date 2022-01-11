import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';

import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/profile_banner.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/profile_banner/profile_banner_bloc.dart';


import 'favorite_movies_grid_view.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({@required this.user}) :assert(user != null);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FavoriteMoviesBloc _favoriteMoviesBloc;
  ProfileBannerBloc _profileBannerBloc;

  @override
  void initState() {
    super.initState();
    print('Loaded Profile of ${widget.user.id}');
    _profileBannerBloc = getItInstance<ProfileBannerBloc>();
    _profileBannerBloc.add(LoadProfileBannerEvent(userID: widget.user.id));
    _favoriteMoviesBloc = getItInstance<FavoriteMoviesBloc>();
    _favoriteMoviesBloc.add(LoadFavoriteMovieEvent(userID: widget.user.id));
  }

  @override
  void dispose() {
    _profileBannerBloc?.close();
    _favoriteMoviesBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.watch_later_rounded, color: Colors.white,),
            onPressed: (){
              Navigator.pushNamed(context, RouteList.myWatchAlongs);
            },
          ) ,
          backgroundColor: Color(0xff090910),
            actions: [
              IconButton(
                icon: Icon(Icons.device_unknown, color: Colors.white,),
                onPressed: (){
                  Navigator.pushNamed(context, RouteList.aboutPage);
                },
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context,RouteList.initial, (route) => false);
                  BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationExited());
                },
              )
            ],
        ),
        backgroundColor: ThemeColors.vulcan,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocProvider<ProfileBannerBloc>(
                create: (context) => _profileBannerBloc,
                child: BlocBuilder<ProfileBannerBloc, ProfileBannerState>(
                  builder: (context, state) {
                    print(state);
                    if(state is ProfileBannerLoading || state is ProfileBannerInitial){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Loading",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                          ),
                          CircularProgressIndicator()
                        ],
                      );
                    }
                    else if(state is ProfileBannerFinalLoaded){
                      return ProfileBanner(user: widget.user,
                        isFollowed: state.isFollowed,
                        followerCount: state.followerCount,
                          followingCount: state.followingCount,
                      );
                    }
                    return Center(
                      child: Text(
                        'Undefined State',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocProvider.value
                (value: _favoriteMoviesBloc,
                child: BlocBuilder<FavoriteMoviesBloc, FavoriteMoviesState>(
                  builder: (context, state) {
                    print(state);
                    if (state is FavoriteMoviesLoaded) {
                      if (state.favoritedMovies.isEmpty) {
                        return Center(
                          child: Text(
                            'No favorites',
                            textAlign: TextAlign.center,
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(color: Colors.white,)
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'FAVORITES',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w100
                                    )
                                  ),
                                ),
                                Expanded(
                                    child: Divider(color: Colors.white,)
                                ),
                              ],
                            ),
                            FavoriteMoviesGridView(
                                movies: state.favoritedMovies
                            ),
                          ],
                        );
                      }
                    } else if (state is FavoriteMoviesLoading) {
                      return SizedBox.shrink();
                    }
                    return Center(child: Center(
                      child: Text(
                        'Undefined state in favoriteMoviesBloc: $state: profilePage'
                      ),
                    ));
                  },
                )
                ,)
            ],
          ),
        ),
      ),
    );
  }
}
