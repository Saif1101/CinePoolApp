import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/di/get_it.dart';

import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/activity_feed/activity_feed_tile.dart';
import 'package:socialentertainmentclub/presentation/blocs/activity_feed/activity_feed_bloc.dart';

class ActivityFeedPage extends StatefulWidget {
  const ActivityFeedPage();

  @override
  _ActivityFeedPageState createState() => _ActivityFeedPageState();
}

class _ActivityFeedPageState extends State<ActivityFeedPage> {
  ActivityFeedBloc activityFeedBloc;

  @override
  void initState() {
    super.initState();
    activityFeedBloc = getItInstance<ActivityFeedBloc>(); 
    activityFeedBloc.add(LoadActivityFeedEvent()); 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.vulcan,
          centerTitle: true,
          title: Center(
            child: RadiantGradientMask(
              child: Text("Activity",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),),
            ),
          ),
        ),
        backgroundColor: ThemeColors.primaryColor.withOpacity(0.27),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 1.0),
          child: BlocProvider.value(
            value: activityFeedBloc,
            child: BlocBuilder<ActivityFeedBloc,ActivityFeedState>(
              builder: (context,state){
                if(state is ActivityFeedInitial || state is ActivityFeedLoading){
                  return Center(
                    child: RadiantGradientMask(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else if(state is ActivityFeedLoaded){
                  if(state.feedItems.length>0){ 
                    return ListView.builder(
                    itemCount: state.feedItems.length,
                    itemBuilder: (context,index){
                      if(state.feedItems[index].runtimeType.toString()=='VoteRecommendActivity')
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RouteList.showPostFromFeedPage, arguments:state.feedItems[index])
                              .then((value) =>activityFeedBloc.add(LoadActivityFeedEvent()));
                            },
                            child: AddVoteRecommendationActivityTile(voteRecommendActivity: state.feedItems[index])
                            );
                      else if(state.feedItems[index].runtimeType.toString()=='NewFollowerActivity')
                          return NewFollowerActivityTile(newFollowerActivity: state.feedItems[index],);
                      else if(state.feedItems[index].runtimeType.toString()=='OptedInToWatchAlongActivity')
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RouteList.showPostFromFeedPage, arguments:state.feedItems[index])
                              .then((value) =>activityFeedBloc.add(LoadActivityFeedEvent()));
                            },
                            child: OptedInToWatchAlongActivityTile(optedInToWatchAlongActivity: state.feedItems[index],
                            ));
                      return SizedBox.shrink();
                      }
                    );
                  }
                  return Center(child: Text('No Activity',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),),);
                }
                return Center(child: Text('Undefined State In ActivityFeedBloc: $state',style: TextStyle(color: Colors.white),),);
              },
              ),
              ),
        ),
      ),
    );
  }
}