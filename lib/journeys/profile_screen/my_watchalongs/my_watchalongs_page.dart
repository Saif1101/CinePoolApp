import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/journeys/timeline/WatchAlongCard.dart';
import 'package:socialentertainmentclub/presentation/blocs/my_watch_alongs/my_watch_alongs_bloc.dart';

class MyWatchAlongsPage extends StatefulWidget {
  @override
  _MyWatchAlongsPageState createState() => _MyWatchAlongsPageState();
}

class _MyWatchAlongsPageState extends State<MyWatchAlongsPage> {
  MyWatchAlongsBloc myWatchAlongsBloc;

  @override
  void initState() {
    super.initState();
    myWatchAlongsBloc = getItInstance<MyWatchAlongsBloc>();
    myWatchAlongsBloc.add(LoadMyWatchAlongsEvent());
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<MyWatchAlongsBloc>(
        create: (context) => myWatchAlongsBloc,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'My Watch-Alongs',
                style: TextStyle(
                  fontSize: FontSize.large,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ),
          backgroundColor: Color(0xFF142e4a),
          body: BlocBuilder<MyWatchAlongsBloc, MyWatchAlongsState>(
            builder: (context, state) {
              if(state is MyWatchAlongsLoaded){
                if (state.myWatchAlongs.length == 0) {
                  return Center(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'No Watch-Alongs to show',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Opt into your friends\' Watch-Alongs and get watching!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ));
                }
                else {
                  return ListView.builder(
                    itemCount: state.myWatchAlongs.length,
                    itemBuilder: (context, index) {
                      return WatchAlongCard(state.myWatchAlongs[index]);
                    },
                  );
                }
              } else if(state is MyWatchAlongsLoading){
                return RadiantGradientMask(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(child: Text("Undefined state in MyWatchAlongsPage"));
            },
          ),
        ),
      ),
    );
  }
}
