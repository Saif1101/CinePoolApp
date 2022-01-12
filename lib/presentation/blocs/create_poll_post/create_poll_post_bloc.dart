import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/CreatePosts/CreatePollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MapOfGenres.dart';
import 'package:socialentertainmentclub/entities/MovieEntity.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

part 'create_poll_post_event.dart';
part 'create_poll_post_state.dart';

class CreatePollPostBloc extends Bloc<PollPostEvent, PollPostState> {
  final GetMapOfGenres getMapOfGenres;
  final CreatePollPost createPollPost;
  //need to create and add CreateRecommendationsPoll Usecases
  
  CreatePollPostBloc({
    @required this.getMapOfGenres,
    @required this.createPollPost
  }) : super(CreatePollPostInitial());

  @override
  Stream<PollPostState> mapEventToState (PollPostEvent event)
  async* {
    if(event is LoadCreatePollPostPage) {
      yield CreatePollPostLoading();
      yield CreatePollPostLoaded(title: event.title,);
    }
    else if(event is CreatePollPostSubmitEvent){
        yield CreatePollPostLoading();
        if(event.title.length>=4 && event.title.length<=15 &&  event.movies.length>=2){
          final responseEither = await createPollPost(PollPostModel(
              votersMap: {},
              ownerID: FirestoreConstants.currentUserId,
              type: 'PollPost',
              pollOptionsMap: Map.fromIterable(event.movies, key: (e) => e.id.toString(), value: (e) => 0),
            title: event.title,
              )
          );
          yield responseEither.fold(
                  (l) => CreatePollPostError(errorMessage: l.errorMessage, errorType: l.appErrorType),
                  (r) => CreatePollPostSubmitted());
        } else {
          if(event.title.length<4 || event.title.length>15){
            ScaffoldMessenger.of(event.context).showSnackBar(
                SnackBar(backgroundColor: ThemeColors.primaryColor,
                  content: Text("The length of the title should be between 4 and 15 characters",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                ));
          }
        else if(event.movies.length<2){
            ScaffoldMessenger.of(event.context).showSnackBar(
                SnackBar(backgroundColor: ThemeColors.primaryColor,
                  content: Text("Add A Movie To Your Poll",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                ));
          }
          yield CreatePollPostLoaded(
              title: event.title,
          );
      }
    }
  }
}
