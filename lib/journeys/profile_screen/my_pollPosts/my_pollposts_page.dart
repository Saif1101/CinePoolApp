import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/journeys/timeline/PollPost/PollPostCard.dart';
import 'package:socialentertainmentclub/presentation/blocs/my_poll_posts/mypollposts_bloc.dart';

class MyPollPosts extends StatefulWidget {

  @override
  _MyPollPostsState createState() => _MyPollPostsState();
}

class _MyPollPostsState extends State<MyPollPosts> {
  MyPollPostsBloc myPollPostsBloc; 

  @override
  void initState() {
    super.initState();
    myPollPostsBloc = getItInstance<MyPollPostsBloc>();
    myPollPostsBloc.add(LoadMyPollPostsEvent());
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value:myPollPostsBloc,
        child:Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'My Polls',
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
          body: BlocBuilder<MyPollPostsBloc, MyPollPostsState>(
            builder: (context, state) {
              if(state is MyPollPostsLoaded){
                if (state.myPollPosts.length == 0) {
                  return Center(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'No Posts To Show',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Go To Your Timeline To Host Polls!",
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
                    itemCount: state.myPollPosts.length,
                    itemBuilder: (context, index) {
                      return PollPostCard(state.myPollPosts[index]);
                    },
                  );
                }
              } else if(state is MyPollPostsLoading){
                return RadiantGradientMask(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(child: Text("Undefined state in MyPollPostsPage"));
            },
          ),
        ),
        )
    );
  }
}