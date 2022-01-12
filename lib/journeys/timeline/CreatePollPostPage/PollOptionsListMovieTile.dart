import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/presentation/blocs/recommendations_poll_movie_list/recommendations_poll_list_bloc.dart';

class RecommendationListMovieTile extends StatelessWidget {
  final MovieEntity movie;
  final RecommendationsPollListBloc recommendationsPollListBloc;

  const RecommendationListMovieTile({Key key, @required this.movie, @required this.recommendationsPollListBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: CircleAvatar(
        backgroundImage: movie.posterPath!=null?CachedNetworkImageProvider(
          '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
          maxWidth: (ScreenUtil.screenWidth~/4),
        ):AssetImage('assets/images/FreeVector-Sync-Slate.jpg'),
      ),
      title: Text(
        movie.title,
        style: TextStyle(
          color: Colors.black
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.close,
        color: Colors.blueGrey,),
        onPressed: (){
        this.recommendationsPollListBloc.add(RemoveMovieRecommendationEvent(this.movie.id.toString()));},
      ),
    );
  }
}
