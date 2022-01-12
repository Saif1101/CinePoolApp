

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/presentation/fade_page_routeBuilder.dart';
import 'package:socialentertainmentclub/presentation/routes.dart';
import 'package:socialentertainmentclub/presentation/wiredash_app.dart';
import 'common/constants/route_constants.dart';
import 'di/get_it.dart';

import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';



import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;
import 'helpers/theme_colors.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  ScreenUtil.init();
  unawaited(getIt.init());
  runApp(MyNewApp());
}


class MyNewApp extends StatefulWidget {
  @override
  _MyNewAppState createState() => _MyNewAppState();
}

class _MyNewAppState extends State<MyNewApp> {
  AuthenticationBloc authenticationBloc;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    authenticationBloc = getItInstance<AuthenticationBloc>();
    authenticationBloc.add(CheckIfUserAlreadySignedInEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {

    return WiredashApp(
      navigatorKey: _navigatorKey,
      child: BlocProvider(
        create: (context) => authenticationBloc,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: Colors.black,
            scaffoldBackgroundColor: ThemeColors.scaffoldBgColor,
          ),
          builder: (context,child){
            return child;
          },
            initialRoute: RouteList.initial,
            onGenerateRoute: (RouteSettings settings) {
              final routes = Routes.getRoutes(settings);
              final WidgetBuilder builder = routes[settings.name];
              return FadePageRouteBuilder(
                builder: builder,
                settings: settings,
              );
            },
        ),
      ),
    );
  }
}



