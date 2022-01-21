import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';

import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/common/extensions/num_extensions.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/WatchAlong/WatchAlongForm.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/movie_detail_app_bar.dart';
import 'package:socialentertainmentclub/presentation/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_form/watch_along_bloc.dart';


class MoviePoster extends StatelessWidget {
  final MovieDetailEntity movie;

  const MoviePoster({Key key, this.movie}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor
              ]
            )
          ),
          child: movie.posterPath!=null?CachedNetworkImage(
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
            width: ScreenUtil.screenWidth,
          ):Image.asset('assets/images/FreeVector-Sync-Slate.jpg', width: ScreenUtil.screenWidth,),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: ListTile(
            title: Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Sizes.dimen_8.h,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              movie.releaseDate ?? '',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<FavoriteMoviesBloc, FavoriteMoviesState>(
                    builder: (context, state) {
                      if(state is IsFavoriteMovie){
                        return GestureDetector(
                          onTap: (){BlocProvider.of<FavoriteMoviesBloc>(context)
                              .add(ToggleFavoriteMovieEvent(movieEntity: MovieEntity.fromMovieDetailEntity(movie),
                          isFavorite: state.isMovieFavorite
                          ),
                          );
                          },

                            child: Icon(
                              state.isMovieFavorite? Icons.favorite:Icons.favorite_border,
                              color: Colors.red,
                              size: Sizes.dimen_32.w,
                              semanticLabel: 'Text to announce in accessibility modes',
                          ),
                        );
                      }
                      return Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: Sizes.dimen_32.w,
                        semanticLabel: 'Text to announce in accessibility modes',);
                      },),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.voteAverage.convertToPercentageString(),
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
            child: MovieDetailAppBar()),
        Positioned(
          left:0,
          right: 0,
          top: ScreenUtil.statusBarHeight + Sizes.dimen_2.h,
          child: BlocConsumer<WatchAlongFormBloc, WatchAlongState>(
            listener: (blocContext,state){
              if(state is CreateWatchAlongState){
                return showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (ctx) => BlocProvider<WatchAlongFormBloc>.value(
                    value: context.read<WatchAlongFormBloc>(),
                    child: Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0))),
                        backgroundColor: ThemeColors.vulcan,
                        insetPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: SingleChildScrollView(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              WatchAlongForm(moviePosterPath: movie.posterPath,
                                  movieID: movie.movieID.toString(),
                                  movieTitle: movie.title),
                              Positioned(
                                top:  -12,
                                child: Text("WATCH ALONG",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                ).then((value) => BlocProvider.of<WatchAlongFormBloc>(context).add(CheckIfScheduledEvent(movie.movieID)));
              }
            },
            builder: (context, state)
            {
              if(state is IsScheduled){
                return Align(
                  child: Card(
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10,
                    color: state.watchAlongID!="NA"?Colors.greenAccent:Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          BlocProvider.of<WatchAlongFormBloc>(context).add(ToggleScheduleWatchAlongEvent(watchAlongID: state.watchAlongID,
                        
                              movieID: movie.movieID.toString())
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              color:state.watchAlongID!="NA"?Colors.green:Colors.red,
                              size: Sizes.dimen_48.w,
                            ),
                            state.watchAlongID!="NA"? Text('Scheduled',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                                fontSize: 16,
                            ),) : Text("Watch-along", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              else if (state is WatchAlongLoading || state is CreateWatchAlongState || state is WatchAlongInitial){
                return Center(
                  child: RadiantGradientMask(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(child: Text('Undefined State In WatchAlong Bloc Builder $state', style: TextStyle(
                color: Colors.white
              ),));
  },
),
        ),
      ],
    );
  }
}
