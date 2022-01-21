import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MovieDetail.dart';

import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/delete_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/get_WatchAlongParticipants.dart';
import 'package:socialentertainmentclub/entities/DeleteWatchAlongParams.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
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
  final DeleteWatchAlong deleteWatchAlong; 
  final GetWatchAlongParticipants getWatchAlongParticipants; 

  WatchAlongPostBloc({
    @required this.getWatchAlongParticipants,
    @required this.deleteWatchAlong,
    @required this.watchAlongParticipationBloc,
    @required this.getUserFromID,
    @required this.getMovieDetail,
   }) : super(WatchAlongPostInitial()){
     on<LoadWatchAlongEvent>(_onLoadWatchAlongEvent);
     on<DeleteWatchAlongEvent>(_onDeleteWatchAlongEvent);
   }

   Future<void> _onDeleteWatchAlongEvent(
      DeleteWatchAlongEvent event, 
     Emitter<WatchAlongPostState>emit,
     ) async {
       emit(WatchAlongPostLoading());
       final response = await deleteWatchAlong(DeleteWatchAlongParams(watchAlongID: event.watchAlongID, movieID: event.movieID));
       emit(response.fold(
         (l) => WatchAlongPostError(errorMessage: l.errorMessage, appErrorType: l.appErrorType), 
         (r) => WatchAlongPostDeleted())
         );

   }

   Future<void> _onLoadWatchAlongEvent(
     LoadWatchAlongEvent event, 
     Emitter<WatchAlongPostState>emit, 
   ) async {
     emit (WatchAlongPostLoading());
      final user = await getUserFromID(event.watchAlong.ownerID);
      final movieDetail = await getMovieDetail(MovieParams(movieID: int.parse(event.watchAlong.movieID)));
      if(user.isRight() && movieDetail.isRight()){
        emit(WatchAlongPostLoaded(watchAlongPostModel: WatchAlongPostModel(
            movieDetailEntity: movieDetail.getOrElse(null),
          user: user.getOrElse(null),
          watchAlong: event.watchAlong,
        )),
        );
      } else{
        emit(WatchAlongPostError(
          appErrorType: AppErrorType.database
        ));
      }
      watchAlongParticipationBloc.add(CheckIfParticipantEvent(event.watchAlong.watchAlongID));
   }

/* LEGACY mapEventToState
  @override
  Stream<WatchAlongPostState> mapEventToState(WatchAlongPostEvent event)
  async* {
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
        yield WatchAlongPostError(
          appErrorType: AppErrorType.database
        );
      }
      watchAlongParticipationBloc.add(CheckIfParticipantEvent(event.watchAlong.watchAlongID));

    }
  }
  */
}
