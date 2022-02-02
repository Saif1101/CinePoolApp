import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/timeline/AskForRecommendationsPost/AskForRecommendationsCard.dart';
import 'package:socialentertainmentclub/journeys/timeline/PollPost/PollPostCard.dart';
import 'package:socialentertainmentclub/journeys/timeline/WatchAlongCard.dart';
import 'package:socialentertainmentclub/presentation/blocs/post_from_feed/post_from_feed_bloc.dart';
import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';

class ShowPostFromFeedPage extends StatefulWidget {
  final FeedActivityItem feedActivityItem;
  const ShowPostFromFeedPage({@required this.feedActivityItem});

  @override
  _ShowPostFromFeedPageState createState() => _ShowPostFromFeedPageState();
}

class _ShowPostFromFeedPageState extends State<ShowPostFromFeedPage> {
  PostFromFeedBloc postFromFeedBloc;

  @override
  void initState() {
    super.initState();
    postFromFeedBloc = getItInstance<PostFromFeedBloc>();
    if(widget.feedActivityItem.type=='NewFollower'){
      postFromFeedBloc.add(LoadFollowerProfileEvent(widget.feedActivityItem));
    } else{
        postFromFeedBloc.add(LoadPostEvent(widget.feedActivityItem));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryColor.withOpacity(0.27),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: BlocProvider.value(
          value: postFromFeedBloc,
          child: BlocConsumer<PostFromFeedBloc, PostFromFeedState>(
              listener: (context,state){
                if(state is FollowerProfileLoadedState){
                  Navigator.pushReplacementNamed(context, RouteList.profilePage,arguments: state.user);
                }
              },
              builder: (context, state) {
            if (state is PostFromFeedLoading) {
              return Center(
                child: RadiantGradientMask(child: CircularProgressIndicator()),
              );
            } else if (state is PostFromFeedError) {
              print("Error type: ${state.errorMessage}");
              return AppErrorWidget(
                errorType: state.appErrorType,
                onPressed: () => postFromFeedBloc
                    .add(LoadPostEvent(widget.feedActivityItem)),
              );
            } else if (state is PostFromFeedLoaded) {
              if (state.post.runtimeType.toString() == 'WatchAlong') {
                return WatchAlongCard(state.post);
              } else if (state.post.runtimeType.toString() ==
                  'AskForRecommendationsPostModel') {
                return AskForRecommendationsCard(state.post);
              } else if (state.post.runtimeType.toString() == 'PollPostModel') {
                return PollPostCard(state.post);
              } else {
                postFromFeedBloc.add(DeleteActivityForPostEvent(
                    activityID: widget.feedActivityItem.type != 'NewFollower'
                        ? widget.feedActivityItem.postID +
                            widget.feedActivityItem.actorUserID
                        : widget.feedActivityItem.actorUserID));//If activity type is AddVote/Recomm/Watchalong,
                        //ID is postID + actorID,
                        // if activity type is newfollower; the id is just the actor id
                return Center(
                    child: Container(
                  color: Colors.white,
                  child: SizedBox.expand(
                    child: Center(
                      child: Text(
                        'Could Not Find The Post',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ));
              }
            }
            return Center(
              child: Text("Undefined State In Post From Feed Bloc: $state",
                  style: TextStyle(color: Colors.white)),
            );
          }),
        ),
      ),
    );
  }
}
