import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MovieDetail.dart';

import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/entities/movie_params.dart';

import 'package:socialentertainmentclub/models/WatchAlong.dart';
import 'package:socialentertainmentclub/models/WatchAlongPost.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_participation/watch_along_participation_bloc.dart';

part 'watch_along_post_event.dart';
part 'watch_along_post_state.dart';

class WatchAlongPostBloc extends Bloc<WatchAlongPostEvent, WatchAlongPostState> {
  final GetUserFromID getUserFromID;
  final GetMovieDetail getMovieDetail;
  final WatchAlongParticipationBloc watchAlongParticipationBloc;

  WatchAlongPostBloc({
    @required this.watchAlongParticipationBloc,
    @required this.getUserFromID,
    @required this.getMovieDetail,
   }) : super(WatchAlongPostInitial());

  @override
  Stream<WatchAlongPostState> mapEventToState(WatchAlongPostEvent event)
  async* {
    print("Inside WatchAlongPostBloc : incoming event is $event");
    if(event is LoadWatchAlongEvent){
      yield WatchAlongPostLoading();
      final user = await getUserFromID(event.watchAlong.ownerID);
      final movieDetail = await getMovieDetail(MovieParams(movieID: int.parse(event.watchAlong.movieID)));
      if(user.isRight() && movieDetail.isRight()){
        yield WatchAlongPostLoaded(watchAlongPostModel: WatchAlongPostModel(
            movieDetailEntity: movieDetail.getOrElse(null),
          user: user.getOrElse(null),
          watchAlong: event.watchAlong,
        ),
        );
      } else{
        yield WatchAlongPostError();
      }
      watchAlongParticipationBloc.add(CheckIfParticipantEvent(event.watchAlong.watchAlongID));

    }
  }
}
