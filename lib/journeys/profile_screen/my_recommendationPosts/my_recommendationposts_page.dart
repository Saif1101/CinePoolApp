import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/journeys/timeline/AskForRecommendationsPost/AskForRecommendationsCard.dart';
import 'package:socialentertainmentclub/presentation/blocs/my_recommendation_posts/myrecommendationposts_bloc.dart';

class MyRecommendationPosts extends StatefulWidget {
  @override
  _MyRecommendationPostsState createState() => _MyRecommendationPostsState();
}

class _MyRecommendationPostsState extends State<MyRecommendationPosts> {
  MyRecommendationPostsBloc myRecommendationPostsBloc;

  @override
  void initState() {
    super.initState();
    myRecommendationPostsBloc = getItInstance<MyRecommendationPostsBloc>();
    myRecommendationPostsBloc.add(LoadMyRecommendationPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
      value: myRecommendationPostsBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Recommendations',
              style: TextStyle(
                  fontSize: FontSize.large,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF142e4a),
        body:
            BlocBuilder<MyRecommendationPostsBloc, MyRecommendationPostsState>(
          builder: (context, state) {
            if (state is MyRecommendationPostsLoaded) {
              if (state.myRecommendationPosts.length == 0) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Head to your timeline to ask your friends for movie recommendations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    
                  ],
                ));
              } else {
                return ListView.builder(
                  itemCount: state.myRecommendationPosts.length,
                  itemBuilder: (context, index) {
                    return AskForRecommendationsCard(
                        state.myRecommendationPosts[index]);
                  },
                );
              }
            } else if (state is MyRecommendationPostsLoading) {
              return RadiantGradientMask(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Center(
                child: Text("Undefined state in MyRecommendationPostsPage"));
          },
        ),
      ),
    ));
  }
}
