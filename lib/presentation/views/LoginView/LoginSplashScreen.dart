import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';


class LoginSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Builder(
            builder: (context){
              return BlocConsumer<AuthenticationBloc, AuthenticationState> (
                listener: (context, state) {
                  if(state is AuthenticationSuccess){
                    //PUSH TO EXPLORE PAGE
                    Navigator.pushReplacementNamed(context,RouteList.initial); // Configuring the homeview to handle all page changes. the homeview will decide whether
                    // push to the explore page or back to the login page.
                  }
                },
                buildWhen: (current, next){
                  if(next is AuthenticationSuccess){
                    //If authenticationState is a success, -> we do not want to
                    //build the same widget again--> instead --> redirect to explore page
                    return false;
                  }
                  return true;
                  },
                builder: (context, state){
                  if(state is AuthenticationInitial || state is AuthenticationFailure){
                    return Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.vulcan
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            fit: BoxFit.contain,
                              image: AssetImage('assets/images/CinePool.gif')),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: ()=> BlocProvider.of<AuthenticationBloc>(context).add(
                                AuthenticationStarted()),
                              child: Container(
                                width: 260.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/googleSignIn.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  else if ( state is AuthenticationLoading){
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(
                      child: Text('Undefined state : ${state.runtimeType}'));
                },
              );
            },
          )
      ),
    );
  }
}
