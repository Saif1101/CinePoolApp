

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/entities/NewUserSignUpParams.dart';

import 'package:socialentertainmentclub/helpers/theme_colors.dart';

import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';


import 'package:socialentertainmentclub/presentation/views/signUpView/widgets/CustomTextField.dart';
import 'package:socialentertainmentclub/presentation/views/signUpView/widgets/GenreTagField.dart';
import 'package:socialentertainmentclub/presentation/views/signUpView/widgets/Header.dart';
import 'package:socialentertainmentclub/presentation/views/signUpView/widgets/Sub_header.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/loginButton.dart';


class NewUserSignUp extends StatefulWidget {
  final NewUserSignUpParams newUserSignUpParams;

  const NewUserSignUp({@required
  this.newUserSignUpParams});

  @override
  _NewUserSignUpState createState() => _NewUserSignUpState();
}

class _NewUserSignUpState extends State<NewUserSignUp> {

  TextEditingController usernameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context,state){
            print('$state in registration listener');
           if(state is RegistrationComplete){
              //PUSH TO EXPLORE PAGE
             Navigator.pushNamedAndRemoveUntil(context, RouteList.initial, (route) => false); // Configuring the homeview to handle all page changes. the homeview will decide whether
              // push to the explore page or back to the login page.
            }
          },
          buildWhen: (current, next){
            if(next is RegistrationComplete||next is AuthenticationSuccess){
              //If authenticationState is a success, -> we do not want to
              //build the same widget again--> instead --> redirect to explore page
              return false;
            }
            return true;
          },
            builder: (context,state){
              print('$state in registration builder');
              if(state is RegistrationPageLoaded){
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  key: _scaffoldKey,
                  backgroundColor: ThemeColors.vulcan,
                  body: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Header(heading: "New here? Welcome!"),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: SubHeader(subHeading: "Please fill the form to continue."),
                          ),
                          SizedBox(height: 70),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                ///userName Input Field
                                CustomTextField(
                                  controller: usernameController,
                                  hintText: "Pick a Username",
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          GenreTagField(genreMap: state.mapOfGenres, tagStateKey: _tagStateKey,),
                          SizedBox(height: 16),
                          MainButton(
                            text: 'Sign Up',
                            onTap: () {
                              context.read<AuthenticationBloc>().add(SignUpButtonPress(
                                  mapGenresWithID: state.mapOfGenres,
                                  timestamp: Timestamp.now().toString(),
                                  email: widget.newUserSignUpParams.email,
                                  username: usernameController.text,
                                  photoUrl: widget.newUserSignUpParams.photoUrl,
                                  displayName: widget.newUserSignUpParams.displayName,
                                  context:context,
                                  tagStateKey: _tagStateKey,
                                  id: widget.newUserSignUpParams.uid));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            else if(state is  RegistrationLoading){
                return CircularProgressIndicator();
              }
              if(state is UserDetailsUpdated){
                FirestoreConstants.getCurrentUser(state.currentUser);
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(UserUpdateCompleteEvent());
                return CircularProgressIndicator();
              }
              //create the body of the sign up form here(return the scaffold..)
              return Center(child: Text("UndefinedState in RegistrationPage $state",style:TextStyle(color: Colors.white)));
            },

        ),
      ),
    );
  }
}
