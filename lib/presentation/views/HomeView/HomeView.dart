

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/entities/NewUserSignUpParams.dart';

import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:socialentertainmentclub/presentation/views/LoginView/LoginSplashScreen.dart';



class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              Navigator.pushReplacementNamed(context,RouteList.loginPage);
            }
            else if (state is AuthenticationSuccessRecordDoesntExist) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LoadRegistrationPage());
              Navigator.pushReplacementNamed(
                  context,RouteList.signUpPage, arguments: NewUserSignUpParams(
                      uid: state.authenticationDetail.uid,
                      displayName: state.authenticationDetail.name,
                      email: state.authenticationDetail.email,
                      photoUrl: state.authenticationDetail.photoUrl)
              );
            }
            else if (state is AuthenticationSuccess || state is UserDetailsUpdateEvent) {
              Navigator.pushReplacementNamed(context, RouteList.mainPage,
                  arguments: FirestoreConstants.currentUser,);
            }
          },
          buildWhen: (prev, curr){
            if(curr is AuthenticationSuccess|| curr is RegistrationComplete){
              return false;
            }
            return true;
          },
          builder: (context, state){
            if (state is AuthenticationInitial) {
              return LoginSplashScreen();
            }
            else if (state is AuthenticationLoading) {
              return Center(child: CircularProgressIndicator());
            }
            else if(state is  RegistrationLoading){
              return CircularProgressIndicator();
            }else if(state is UserDetailsUpdated){
              FirestoreConstants.getCurrentUser(state.currentUser);
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(UserUpdateCompleteEvent());
              return CircularProgressIndicator();
            } else if(state is UserAlreadyLoggedInState){
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationStarted());
            } else if (state is RegistrationComplete){
            FirestoreConstants.getCurrentUser(state.currentUser);
            BlocProvider.of<AuthenticationBloc>(context)
                .add(UserUpdateCompleteEvent());
            return CircularProgressIndicator();
            }
            return Center(
              child: Container(
                child: Text(
                  'UndefinedState inside HomeView $state',
                  style: TextStyle
                    (color: Colors.white30),
                ),
              ),
            );
            },
        ),
      ),
    );
  }
}
