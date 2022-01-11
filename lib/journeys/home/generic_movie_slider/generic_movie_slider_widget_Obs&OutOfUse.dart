

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/generic_movie_slider/generic_movie_slider_bloc.dart';
import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';

import 'child_movie_slider_horizontal.dart';

/*class GenericMovieSliderWidget extends StatefulWidget {
  final UserModel currentUser;

  const GenericMovieSliderWidget({this.currentUser}): assert(currentUser!=null, "currentUser can't be null");

  @override
  _GenericMovieSliderWidgetState createState() => _GenericMovieSliderWidgetState();
}

class _GenericMovieSliderWidgetState extends State<GenericMovieSliderWidget> with
SingleTickerProviderStateMixin{

  GenericMovieSliderBloc get movieSliderBloc => BlocProvider.of<GenericMovieSliderBloc>(context);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericMovieSliderBloc,GenericMovieSliderState>(
      builder: (context, sliderState) {
        if(sliderState is GenericMoveSliderLoaded){
          return ListView.separated(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount:sliderState.genreIDNameMap.length,
            scrollDirection: Axis.vertical,

            separatorBuilder: (context,index){
              return SizedBox(
                height: 25,
              );
            },
            itemBuilder: (context, index){
              String genreID = sliderState.genreIDNameMap.keys.elementAt(index);
              String genreName = sliderState.genreIDNameMap[genreID];
              String key = sliderState.moviesByGenreMap.keys.elementAt(index);
              return horizontalGenreSliderBuilder(genreName: genreName,movies: sliderState.moviesByGenreMap[key]);
            },
          );
        } else if(sliderState is GenericMoveSliderError){
          return AppErrorWidget(errorType: sliderState.errorType,
            onPressed: ()=>movieSliderBloc.add(GenericMovieSliderLoadEvent
              (genreMap: widget.currentUser.genres,getMoviesByGenre: genericMovieSliderBloc.getMoviesByGenre)),
            errorMessage: sliderState.errorMessage,);
        }
        return const SizedBox.shrink();
      },
    );
  }
}*/

