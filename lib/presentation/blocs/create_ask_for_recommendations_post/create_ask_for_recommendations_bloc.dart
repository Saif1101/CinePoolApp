import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:meta/meta.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/CreatePosts/CreateAskForRecommendations.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MapOfGenres.dart';

import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';

part 'create_ask_for_recommendations_event.dart';
part 'create_ask_for_recommendations_state.dart';

class CreateAskForRecommendationsBloc extends Bloc<CreateAskForRecommendationsEvent, CreateAskForRecommendationsState> {
  final GetMapOfGenres getMapOfGenres;
  final CreateAskForRecommendationsPost createAskForRecommendationsPost;

  CreateAskForRecommendationsBloc(
     {@required this.getMapOfGenres,
     @required this.createAskForRecommendationsPost,
      }) : super(CreateAskForRecommendationsPostInitial());

  @override
  Stream<CreateAskForRecommendationsState> mapEventToState(CreateAskForRecommendationsEvent event)
  async * {
    if(event is LoadAskForRecommendationsEvent){
      final mapOfGenresEither = await getMapOfGenres(NoParams());
      yield mapOfGenresEither.fold(
              (l) => CreateAskForRecommendationsPostError(l.errorMessage,l.appErrorType),
              (r) => CreateAskForRecommendationsPostLoaded(event.title,event.description,  r));
    }
    else if (event is CreateAskForRecommendationsButtonPress){
      yield CreateAskForRecommendationsPostLoading();
      List<Item> lst = event.tagStateKey.currentState?.getAllItem;
      List<String> genres = [];
      lst.where((a) => a.active==true).forEach( (a) => genres.add(a.title));
      if(event.title.length>=4 && genres.length>=3){
        Map<String, String>  selectedGenres= new Map();
        genres.forEach((element) {
          selectedGenres[(event.mapGenresWithID.keys.firstWhere((k) => event.mapGenresWithID[k] == element).toString())]=element;}
        );

        final responseEither = await
        createAskForRecommendationsPost(
          AskForRecommendationsPostModel(
            preferredGenres: selectedGenres.values.toList(),
            recommendationsTrackMap: {},
            body: event.description,
            type: 'AskForRecommendationsPost',
            ownerID: FirestoreConstants.currentUserId,
          )
        );
        yield responseEither.fold(
                (l) => CreateAskForRecommendationsPostError(l.errorMessage,l.appErrorType),
                (r) => CreateAskForRecommendationsPostSuccess());
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
        else if(event.description.length<4 || event.description.length>56){
          ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBar(backgroundColor: ThemeColors.primaryColor,
                content: Text("The length of the description should be between 4 and 56 characters",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
              ));
        }
        yield CreateAskForRecommendationsPostLoaded(event.title,event.description, event.mapGenresWithID);
      }
    }
  }
}
