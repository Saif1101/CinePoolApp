import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';

import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:wiredash/wiredash.dart';
//AppErrorType {api, network, authentication}

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final String errorMessage;
  final Function onPressed;

  Map<String,String> mapErrorToMessage = {'AppErrorType.api':'A problem occured during the API call.',
    'AppErrorType.network':'There seems to be a problem with your internet connection. Check your connection and try again.',
  'AppErrorType.authentication': 'A problem occured while trying to authenticate the user. Try logging in again.'};

  AppErrorWidget({Key key, @required this.errorType,@required this.onPressed, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.vulcan,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mapErrorToMessage[errorType.toString()],
                  textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                ),
                Text(
                  errorMessage.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: Sizes.dimen_6.h
                        ),
                      ),
                      onPressed: onPressed,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>
                            (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Text(
                        'Feedback',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                            fontSize: Sizes.dimen_6.h
                        ),
                      ),
                      onPressed: () => Wiredash.of(context)?.show(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
