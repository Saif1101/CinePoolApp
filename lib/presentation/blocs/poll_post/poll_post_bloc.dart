import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/PollPosts/delete_PollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/PostActions/CastPollVote.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MovieDetail.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/entities/CastPollVoteParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/entities/movie_params.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

part 'poll_post_event.dart';
part 'poll_post_state.dart';

class PollPostBloc extends Bloc<PollPostEvent, PollPostState> {

  final GetMovieDetail getMovieDetail;
  final GetUserFromID getUserFromID;
  final CastPollVote castPollVote;
  final DeletePollPost deletePollPost; 


  PollPostBloc({
    @required this.deletePollPost,
    @required this.getMovieDetail,
    @required this.getUserFromID,
    @required this.castPollVote}) : super(PollPostInitial()){
      on<LoadPollPostEvent>(_onLoadPollPostEvent);
      on<UpdatePollsEvent>(_onUpdatePollsEvent);
      on<DeletePollPostEvent>(_onDeletePollPostEvent);
    }

    Future<void> _onDeletePollPostEvent(
      DeletePollPostEvent event, 
      Emitter<PollPostState> emit,
    ) async {
      emit(PollPostLoading());
      final response = await deletePollPost(event.postID);
      emit(response.fold(
        (l) => PollPostError(errorMessage: l.errorMessage, appErrorType: l.appErrorType), 
        (r) => PollPostDeleted())
        );

    }

    Future<void> _onLoadPollPostEvent(
      LoadPollPostEvent event,
      Emitter<PollPostState> emit,
    ) async {
      emit(PollPostLoading());
      int errorFlag = 0;
      String errorMessage = '';

      List<MovieDetailEntity> movies = [];

      for(int i= 0; i<event.pollPost.pollOptionsMap.keys.length; i++){
        final response = await getMovieDetail(MovieParams(movieID: int.parse(event.pollPost.pollOptionsMap.keys.elementAt(i))));
        if(response.isRight()){
          movies.add(response.getOrElse(null));
        } else {
          errorFlag = 1;
          errorMessage +=  'Error fetching Movie Details for post.-';
        }
      }

      final user = await getUserFromID(event.pollPost.ownerID);
      if(user.isRight() && errorFlag!=1){
        emit(
          PollPostLoaded(
            pollOptionsMap: event.pollPost.pollOptionsMap,
            movies: movies,
            votersMap: event.pollPost.votersMap,
            postOwner: user.getOrElse(null)
            )
          );
      }
      else{
        emit(PollPostError(errorMessage: errorMessage));
      }
    }

    Future<void> _onUpdatePollsEvent(
      UpdatePollsEvent event, 
      Emitter<PollPostState> emit,
    ) async {
      emit (PollPostLoading());
      final response = await castPollVote(CastPollVoteParams(ownerID: event.owner.id,
            postID: event.postID,
            votersMap: event.votersMap,
            pollOptionsMap: event.pollOptionsMap
        ));

      emit(response.fold(
              (l) =>PollPostError(errorMessage: l.errorMessage, appErrorType: l.appErrorType),
              (r) => PollPostLoaded(movies: event.movies,
                  postOwner: event.owner,
                  pollOptionsMap: event.pollOptionsMap,
                  votersMap: event.votersMap)
      ));

    }

/*
  @override
  Stream<PollPostState> mapEventToState(PollPostEvent event)
  async* {
    if(event is LoadPollPostEvent){
      yield PollPostLoading();
      int errorFlag = 0;
      String errorMessage = '';

      List<MovieDetailEntity> movies = [];

      for(int i= 0; i<event.pollPost.pollOptionsMap.keys.length; i++){
        final response = await getMovieDetail(MovieParams(movieID: int.parse(event.pollPost.pollOptionsMap.keys.elementAt(i))));
        if(response.isRight()){
          movies.add(response.getOrElse(null));
        } else {
          errorFlag = 1;
          errorMessage +=  'Error fetching Movie Details for post.-';
        }
      }

      final user = await getUserFromID(event.pollPost.ownerID);
      if(user.isRight() && errorFlag!=1){
        yield PollPostLoaded(
            pollOptionsMap: event.pollPost.pollOptionsMap,
            movies: movies,
            votersMap: event.pollPost.votersMap,
            postOwner: user.getOrElse(null));
      }
      else{
        yield PollPostError(errorMessage: errorMessage);
      }
    }
    else if(event is UpdatePollsEvent){
      yield PollPostLoading();
      final response = await castPollVote(CastPollVoteParams(ownerID: event.owner.id,
            postID: event.postID,
            votersMap: event.votersMap,
            pollOptionsMap: event.pollOptionsMap
        ));

      yield response.fold(
              (l) =>PollPostError(errorMessage: l.errorMessage, appErrorType: l.appErrorType),
              (r) => PollPostLoaded(movies: event.movies,
                  postOwner: event.owner,
                  pollOptionsMap: event.pollOptionsMap,
                  votersMap: event.votersMap)
      );
    }
  }
  */
}
