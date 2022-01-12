import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';

import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/cast_widget.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/movie_detail_arguments.dart';
import 'package:socialentertainmentclub/journeys/home/movie_detail/movie_poster_widget.dart';
import 'package:socialentertainmentclub/presentation/blocs/cast/cast_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_form/watch_along_bloc.dart';

import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({Key key, this.movieDetailArguments})
      :
        assert(movieDetailArguments !=
            null, "MovieDetailArguments can't be null"),
        super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc _movieDetailBloc;
  CastBloc _castBloc;
  FavoriteMoviesBloc _favoriteMoviesBloc;
  WatchAlongFormBloc _watchAlongBloc;

  @override
  void initState() {
    super.initState();

    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _watchAlongBloc = _movieDetailBloc.watchAlongBloc;
    _favoriteMoviesBloc = _movieDetailBloc.favoriteMoviesBloc;
    _castBloc = _movieDetailBloc.castBloc;
    _movieDetailBloc.add(
        MovieDetailLoadEvent(widget.movieDetailArguments.movieID));
  }

  @override
  void dispose() {
    super.dispose();
    _watchAlongBloc.close();
    _movieDetailBloc.close();
    _castBloc.close();
    _favoriteMoviesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers:[
          BlocProvider.value(value: _watchAlongBloc,),
          BlocProvider.value(value: _movieDetailBloc,),
          BlocProvider.value(value: _castBloc,),
          BlocProvider.value(value: _favoriteMoviesBloc)
          ],
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if(state is MovieDetailLoaded){
                final movieDetail = state.movieDetailEntity;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MoviePoster(movie: movieDetail,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                        ),
                        child: Text(
                          movieDetail.overview,
                          style: TextStyle(
                            fontSize: Sizes.dimen_6.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.dimen_16.w,
                            vertical: Sizes.dimen_18
                        ),
                        child: Text(
                          'Cast',
                          style: TextStyle(
                              fontSize: Sizes.dimen_16.h,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      CastWidget(),
                    ],
                  ),
                );
              }
              else if (state is MovieDetailError){
                return AppErrorWidget(errorType: state.appErrorType, errorMessage: state.errorMessage??'',
                  onPressed: ()=>_movieDetailBloc.add(
                    MovieDetailLoadEvent(widget.movieDetailArguments.movieID)),);
              }
              else if(state is MovieDetailInitial){
                return Center(
                  child: RadiantGradientMask(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(
                child: Container(
                  child: Text(
                    'UndefinedState: $state in MovieDetailScreen',
                    style: TextStyle
                      (color: Colors.white30),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
