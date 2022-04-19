import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MapOfGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_NewUserSignUp.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/check_IfUserAlreadySigned.dart';

import 'package:socialentertainmentclub/domain/usecases/userandauth/get_CurrentFirebaseAccount.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';

import 'package:socialentertainmentclub/domain/usecases/userandauth/set_UsernameAndGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/signOut.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/sign_InWithGoogle.dart';

import 'package:socialentertainmentclub/entities/UserSignUpParams.dart';

import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/models/AuthenticationDetail.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  final NewUserSignUp newUserSignUp;

  final SignOut unauthenticate;
  final SetUsernameAndGenres setUsernameAndGenres;
  final GetMapOfGenres getMapOfGenres;


  final CheckIfUserAlreadySignedIn checkIfUserAlreadySignedIn;
  final SignInWithGoogle signInWithGoogle;
  final GetCurrentFirebaseUser getCurrentFirebaseUser;
  final GetUserFromID getUserFromID;

  AuthenticationBloc({
    @required this.signInWithGoogle,
    @required this.getCurrentFirebaseUser,
    @required this. checkIfUserAlreadySignedIn,
    @required this.getUserFromID,
    @required this.newUserSignUp,

    @required this.unauthenticate,
    @required this.setUsernameAndGenres,
    @required this.getMapOfGenres,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);

    on<CheckIfUserAlreadySignedInEvent>(_onCheckIfUserAlreadySignedInEvent);

    on<AuthenticationExited>(_onAuthenticationExited);

    on<LoadRegistrationPage>(_onLoadRegistrationPage);

    on<SignUpButtonPress>(_onSignUpButtonPress);

    on<UserDetailsUpdateEvent>(_onUserDetailsUpdateEvent);

    on<UserUpdateCompleteEvent>(_onUserUpdateCompleteEvent);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _onAuthenticationStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    FirestoreConstants.init();
    emit(AuthenticationLoading());
  
    final googleSignIn = await signInWithGoogle(NoParams());
    print('GoogleSignIn : $googleSignIn');
    emit(googleSignIn.fold(
      (l) => AuthenticationFailure(message: l.errorMessage,),
      (r){
         FirestoreConstants.getCurrentUser(r);
         return r.isEmpty?
       AuthenticationSuccessRecordDoesntExist(
         authenticationDetail: AuthenticationDetail(
           isValid: true, 
           uid: r.id,
           photoUrl: r.photoUrl,
           email: r.email,
           name: r.displayName
           ))
       :AuthenticationSuccess(currentUser:r);
       }) 
      );

  }

  Future<void> _onCheckIfUserAlreadySignedInEvent(
    CheckIfUserAlreadySignedInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await checkIfUserAlreadySignedIn(NoParams());
    if (response.isRight()){
      bool isSignedIn = response.getOrElse(null); 
      print("Is signed in: $isSignedIn");
      if(isSignedIn){
        emit(UserAlreadyLoggedInState());
      }else{
        emit(AuthenticationInitial());
      }
    } else{
      emit(AuthenticationFailure(message: "Check if user signed in failed"));
    }
    
  }

  Future<void> _onAuthenticationExited(
    AuthenticationExited event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final unauthEither = await unauthenticate(NoParams());
    emit(unauthEither.fold(
        (l) => AuthenticationFailure(message: l.errorMessage),
        (r) => AuthenticationInitial()));
  }

  Future<void> _onLoadRegistrationPage(
    LoadRegistrationPage event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(RegistrationLoading());
    final finalMapOfGenres = await getMapOfGenres(NoParams());
    emit(finalMapOfGenres.fold(
        (l) => RegistrationFailed(
            message: 'Registration Failed While Fetching Map Of Genres '),
        (finalMapOfGenres) =>
            RegistrationPageLoaded(mapOfGenres: finalMapOfGenres)));
  }

  Future<void> _onSignUpButtonPress(
    SignUpButtonPress event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(RegistrationLoading());
    List<Item> lst = event.tagStateKey.currentState?.getAllItem;
    List<String> genres = [];
    lst.where((a) => a.active == true).forEach((a) => genres.add(a.title));
    if (event.username.length >= 4 && genres.length >= 3) {
      Map<String, String> selectedGenres = new Map();
      genres.forEach((element) {
        selectedGenres[(event.mapGenresWithID.keys
            .firstWhere((k) => event.mapGenresWithID[k] == element)
            .toString())] = element;
      });

      final newUserEither = await newUserSignUp(UserSignUpParams(
          id: event.id,
          username: event.username,
          photoUrl: event.photoUrl,
          email: event.email,
          selectedGenres: selectedGenres,
          timestamp: event.timestamp,
          displayName: event.displayName));

      emit(newUserEither.fold(
          (l) => RegistrationFailed(message: l.errorMessage),
          (user) => RegistrationComplete(currentUser: user)));
    } else {
      if (event.username.length < 4) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          backgroundColor: ThemeColors.primaryColor,
          content: Text(
            "The username should be atleast 4 characters long",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      } else if (genres.length < 3) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          backgroundColor: ThemeColors.primaryColor,
          content: Text(
            "Please Select Atleast 3 Genres",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      }
      emit(RegistrationPageLoaded(mapOfGenres: event.mapGenresWithID));
    }
  }

  void _onUserDetailsUpdateEvent(
    UserDetailsUpdateEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    FirestoreConstants.setUsernameAndGenres(
        event.username, event.selectedGenres);
    emit(UserDetailsUpdated(currentUser: FirestoreConstants.currentUser));
  }

  void _onUserUpdateCompleteEvent(
    UserUpdateCompleteEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationSuccess(currentUser: FirestoreConstants.currentUser));
  }

////LEGACY mapEventToState Function

/*
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) 
      async* {


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
   } 
   
   else if (event is UserUpdateCompleteEvent){
      yield AuthenticationSuccess(currentUser:FirestoreConstants.currentUser);
   }


} */
}
