

import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';



import 'movie_slider_card.dart';

class horizontalGenreSliderBuilder extends StatelessWidget {
  final List<MovieEntity> movies;
  final String genreName;

  const horizontalGenreSliderBuilder({Key key, @required this.movies, this.genreName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${this.genreName}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 175,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context,index){
              return SizedBox(
                width: 15.5,
                height: 1,
              );
            },
            itemBuilder: (context, index){
              final MovieEntity movie = movies[index];
              return MovieSliderCardWidget(movieID: movie.id, posterPath: movie.posterPath, title: movie.title,);
            },

          ),
        ),
      ],
    );
  }
}
