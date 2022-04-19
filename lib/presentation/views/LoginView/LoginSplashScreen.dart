import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/entities/NewUserSignUpParams.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';

class LoginSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Builder(
        builder: (context) {
          return BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              print("Inside LoginSplashScreen Listener : $state");
              if (state is AuthenticationSuccess || state is UserAlreadyLoggedInState || state is AuthenticationSuccessRecordDoesntExist) {
                print("Authentication Success");
                //PUSH TO EXPLORE PAGE
                Navigator.pushReplacementNamed(
                    context,
                    RouteList
                        .initial); // Configuring the homeview to handle all page changes. the homeview will decide whether
                // push to the explore page or back to the login page.
              } 
            },
            buildWhen: (current, next) {
              if (next is AuthenticationSuccess || next is UserAlreadyLoggedInState) {
                //If authenticationState is a success, -> we do not want to
                //build the same widget again--> instead --> redirect to explore page
                return false;
              }
              return true;
            },
            builder: (context, state) {
              print(state);
              if (state is AuthenticationInitial ||
                  state is AuthenticationFailure) {
                return Container(
                  decoration: BoxDecoration(color: ThemeColors.vulcan),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.screenWidth,
                        height: ScreenUtil.screenHeight * 0.4,
                        child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/Logo.gif')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                            onTap: () =>
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(AuthenticationStarted()),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              child: SizedBox(
                                height: ScreenUtil.screenHeight / 14,
                                width: ScreenUtil.screenWidth / 2,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                              horizontal: 4.0),
                                          child: SvgPicture.asset(
                                              'assets/images/GoogleLogo.svg'),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                          decoration:
                                              BoxDecoration(color: Colors.blue),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                child: Text(
                                                  'Sign in with Google',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                );
              } else if (state is AuthenticationLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: Text('Undefined state : $state', style: TextStyle(color: Colors.white),));
            },
          );
        },
      )),
    );
  }
}
