import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MapOfGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/set_UsernameAndGenres.dart';

import 'package:socialentertainmentclub/entities/EditProfileParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final SetUsernameAndGenres setUsernameAndGenres;
  final GetMapOfGenres getMapOfGenres;


  EditProfileBloc({@required this.getMapOfGenres, @required this.setUsernameAndGenres}) : super(EditProfileInitial());

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event)
  async* {
    if(event is LoadEditPageEvent){
      final mapOfGenresEither = await getMapOfGenres(NoParams());
      yield mapOfGenresEither.fold(
              (l) => EditProfileError(l.errorMessage,l.appErrorType),
              (r) => EditProfilePageLoaded(event.username, r));
    }
    else if (event is EditButtonPress){
      yield EditProfilePageLoading();
      List<Item> lst = event.tagStateKey.currentState?.getAllItem;
      List<String> genres = [];
      lst.where((a) => a.active==true).forEach( (a) => genres.add(a.title));
      if(event.username.length>=4 && genres.length>=3){
        Map<String, String>  selectedGenres= new Map();
        genres.forEach((element) {
          selectedGenres[(event.mapGenresWithID.keys.firstWhere((k) => event.mapGenresWithID[k] == element).toString())]=element;}
          );

        final responseEither = await
        setUsernameAndGenres(EditProfileParams(event.username,selectedGenres));
        yield responseEither.fold(
                (l) => EditProfileError(l.errorMessage,l.appErrorType),
                (r) => EditProfileSuccess(event.username, selectedGenres));
      } else {
        if(event.username.length<4){
          ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBar(backgroundColor: ThemeColors.primaryColor,
                content: Text("The username should be atleast 4 characters long",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
              ));
        }
        else if(genres.length<3){
          ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBar(backgroundColor: ThemeColors.primaryColor,
                content: Text("Please Select Atleast 3 Genres",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
              ));
        }
        yield EditProfilePageLoaded(event.username, event.mapGenresWithID);
      }
    }

  }
}

