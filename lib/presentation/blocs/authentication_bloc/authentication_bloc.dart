import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MapOfGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_NewUserSignUp.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_AuthenticationDetailFromGoogle.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_User.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/set_UsernameAndGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/unauthenticate.dart';


import 'package:socialentertainmentclub/entities/UserSignUpParams.dart';

import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/firebase_authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final NewUserSignUp newUserSignUp;

  final GetAuthenticationDetailFromGoogle getAuthenticationDetailFromGoogle;
  final GetUserFromAuthDetail getUserFromAuthDetail;
  final Unauthenticate unauthenticate;
  final SetUsernameAndGenres setUsernameAndGenres;
  final GetMapOfGenres getMapOfGenres;
  final AuthenticationFirebaseProvider authenticationFireBaseProvider;



  AuthenticationBloc({@required this.authenticationFireBaseProvider, @required this.newUserSignUp,
    @required this.getAuthenticationDetailFromGoogle,
    @required this.getUserFromAuthDetail,
    @required this.unauthenticate,
    @required this.setUsernameAndGenres,
    @required this.getMapOfGenres,
  }) : super(AuthenticationInitial());


  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {

    print('Inside auth bloc : event : $event');

    if(event is CheckIfUserAlreadySignedInEvent){
      if(authenticationFireBaseProvider.checkIfUserSignedIn()){
        yield UserAlreadyLoggedInState();
      } else{
        yield AuthenticationInitial();
      }
    }
   if (event is AuthenticationStarted) {
        FirestoreConstants.init();
        yield AuthenticationLoading();
        final authEither = await getAuthenticationDetailFromGoogle(NoParams());
        if(authEither.isRight()) {
          AuthenticationDetail authenticationDetail = authEither.getOrElse(null);
          if (authenticationDetail.isValid) {
          //get user's details from firestore
          /*
          authenticationDetail.isValid evaluates to true only if the user has a google account and signs in w it
          After we've checked that the user has a valid user acc, we need to check if he has created an account on our platform -> SocialEntertainmentClub
          To do that-> we'll check our firestoreDB to know if the user's doc exists
          if exists -> store data in the state-> redirect to the explore page(state.data)
          else -> redirect user to sign up page.
           */
          final userEither = await getUserFromAuthDetail(authenticationDetail);

          if(userEither.isRight())
          {
            UserModel currentUser = userEither.getOrElse(null);
            if(currentUser.isNotEmpty){
            FirestoreConstants.getCurrentUser(currentUser);
            yield AuthenticationSuccess(currentUser: FirestoreConstants.currentUser,loginTime: Timestamp.now().toString());
          } else {
            yield AuthenticationSuccessRecordDoesntExist(authenticationDetail: authenticationDetail);
            }
          }else{
            yield AuthenticationFailure(message: 'App Error');
          }
        } else {
            yield AuthenticationFailure(message: 'User detail not found.');
          }
        }

        else {
          yield AuthenticationFailure(message: 'AppError');
        }
    }
    else if (event is AuthenticationExited) {
        yield AuthenticationLoading();
        final unauthEither = await unauthenticate(NoParams());
        yield unauthEither.fold(
                (l) => AuthenticationFailure(message: l.errorMessage),
                (r) => AuthenticationInitial());
    }



   else if (event is LoadRegistrationPage){
     yield RegistrationLoading();
     final finalMapOfGenres = await getMapOfGenres(NoParams());
     yield finalMapOfGenres.fold(
             (l) => RegistrationFailed(message: 'Registration Failed While Fetching Map Of Genres '),
             (finalMapOfGenres) => RegistrationPageLoaded(mapOfGenres: finalMapOfGenres)
     );

   }
   else if(event is SignUpButtonPress){
      yield RegistrationLoading();
      List<Item> lst = event.tagStateKey.currentState?.getAllItem;
      List<String> genres = [];
      lst.where((a) => a.active==true).forEach( (a) => genres.add(a.title));
      if(event.username.length>=4 && genres.length>=3){
        Map<String, String>  selectedGenres= new Map();
        genres.forEach((element) {
          selectedGenres[(event.mapGenresWithID.keys.firstWhere((k) => event.mapGenresWithID[k] == element).toString())]=element;}
        );

        final newUserEither = await newUserSignUp(UserSignUpParams(id: event.id,
            username: event.username,
            photoUrl: event.photoUrl,
            email: event.email,
            selectedGenres: selectedGenres,
            timestamp:  event.timestamp,
            displayName:  event.displayName));
        yield newUserEither.fold(
                (l) => RegistrationFailed(message:l.errorMessage),
                (user) => RegistrationComplete(currentUser:user)
        );
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
        yield RegistrationPageLoaded(mapOfGenres: event.mapGenresWithID);
      }
    }



    else if (event is UserDetailsUpdateEvent){
     FirestoreConstants.setUsernameAndGenres(event.username, event.selectedGenres);
     yield UserDetailsUpdated(currentUser:FirestoreConstants.currentUser);
   } else if (event is UserUpdateCompleteEvent){
      yield AuthenticationSuccess(currentUser:FirestoreConstants.currentUser);
   }


}
}