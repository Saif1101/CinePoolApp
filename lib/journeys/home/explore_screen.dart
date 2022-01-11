
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/generic_movie_slider/generic_movie_slider_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:socialentertainmentclub/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';


import 'generic_movie_slider/child_movie_slider_horizontal.dart';


class ExploreScreen extends StatefulWidget {
  final UserModel currentUser;
  const ExploreScreen({this.currentUser}): assert(currentUser!=null, "currentUser can't be null");
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  MovieCarouselBloc movieCarouselBloc;
  MovieBackdropBloc movieBackdropBloc;
  GenericMovieSliderBloc genericMovieSliderBloc;


  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    genericMovieSliderBloc = getItInstance<GenericMovieSliderBloc>();
    genericMovieSliderBloc.add(GenericMovieSliderLoadEvent(genreMap: widget.currentUser.genres,getMoviesByGenre: genericMovieSliderBloc.getMoviesByGenre));
    movieCarouselBloc.add(CarouselLoadEvent());
  }
  @override
  void dispose() {
    // TODO: implement dispose

    movieCarouselBloc?.close();
    movieBackdropBloc?.close();
    genericMovieSliderBloc?.close();
    super.dispose();
  }
  //a fractionally sized box helps you divide the screen between
  // two or more widgets according to you
  //Using a fractionally sized box: use stackfit.expand
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCarouselBloc>(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider<MovieBackdropBloc>(
          create: (context) => movieBackdropBloc,
        ),
        BlocProvider<GenericMovieSliderBloc>(
          create: (context) => genericMovieSliderBloc,
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: ThemeColors.vulcan,
            body: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
                      cubit: movieCarouselBloc,
                      builder: (context, state) {
                        if (state is MovieCarouselLoaded) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: MovieCarouselWidget(
                              movies: state.movies,
                              defaultIndex: state.defaultIndex,
                            ),
                          );
                      }
                        else if (state is MovieCarouselError){
                          return AppErrorWidget(errorType: state.errorType,errorMessage: state.errorMessage,
                              onPressed: () =>movieCarouselBloc.add(CarouselLoadEvent()));
                        }
                        return const SizedBox.shrink();
                        },
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GenericMovieSliderBloc, GenericMovieSliderState>(
                    builder: (context, state) {
                      if(state is GenericMoveSliderLoaded){
                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.separated(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:state.genreIDNameMap.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context,index){
                              return SizedBox(
                                height: 25,
                              );
                            },
                            itemBuilder: (context, index){
                              String genreID = state.genreIDNameMap.keys.elementAt(index);
                              String genreName = state.genreIDNameMap[genreID];
                              String key = state.moviesByGenreMap.keys.elementAt(index);
                              return horizontalGenreSliderBuilder(genreName: genreName,movies: state.moviesByGenreMap[key]);
                            },
                          ),
                        );
                      }
                      else if(state is GenericMoveSliderError){
                        return AppErrorWidget(errorType: state.errorType,
                          onPressed: ()=> genericMovieSliderBloc.add(GenericMovieSliderLoadEvent(genreMap: widget.currentUser.genres,getMoviesByGenre: genericMovieSliderBloc.getMoviesByGenre)),
                          errorMessage: state.errorMessage,);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
        );
          },
      ),
    );
  }
}