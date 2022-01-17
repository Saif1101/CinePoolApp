import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/timeline/AskForRecommendationsPost/AskForRecommendationsCard.dart';
import 'package:socialentertainmentclub/journeys/timeline/ExpandableFAB.dart';
import 'package:socialentertainmentclub/journeys/timeline/PollPost/PollPostCard.dart';
import 'package:socialentertainmentclub/journeys/timeline/WatchAlongCard.dart';
import 'package:socialentertainmentclub/presentation/blocs/timeline/timeline_bloc.dart';
import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  TimelineBloc timelineBloc;

  @override
  void initState() {
    super.initState();
    timelineBloc = getItInstance<TimelineBloc>();
    timelineBloc.add(LoadTimelineEvent());
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
    value: timelineBloc,
          child: Scaffold(

        floatingActionButton: ExpandableFab(
          distance: 50.0,
          children: [
            ActionButton(
              onPressed: (){Navigator.pushNamed(context, RouteList.createPollPostPage);},
              title: 'Create a poll',
            ),
            ActionButton(
              onPressed: (){Navigator.pushNamed(context, RouteList.createAskForRecommendationsPostPage);},
                title: 'Ask for recommendations',
            ),
          ],
        ),
            backgroundColor: ThemeColors.primaryColor.withOpacity(0.27),
            body: BlocConsumer<TimelineBloc, TimelineState>(
              listener: (context, state) {
          },
          builder: (context, state) {
            if (state is TimelineInitial || state is TimelineLoading) {
              return Center(
                child: RadiantGradientMask(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if (state is TimelineLoaded) {
              if (state.posts.length == 0) {
                return Center(child: Text('No posts to show'));
              }
              else {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {

                    if (state.posts[index].runtimeType.toString() ==
                        'WatchAlong') {
                      return WatchAlongCard(state.posts[index]);
                    } else if (state.posts[index].runtimeType.toString() ==
                        'AskForRecommendationsPostModel') {
                      return AskForRecommendationsCard(state.posts[index]);
                    } else if(state.posts[index].runtimeType.toString() ==
                        'PollPostModel'){
                      return PollPostCard(state.posts[index]);
                    } else{
                      return Center(child: Text('Cant figure out the type'));

                    }
                  },
                );
              }
            }
            else if (state is TimelineError){
              return Center(
                child: AppErrorWidget(
                  onPressed: ()=>{BlocProvider.of<TimelineBloc>(context).add(LoadTimelineEvent())},
                  errorType: state.appErrorType,
                ),
              );
            }
            return Center(
              child: Text(
                'Undefined State In Timeline Page $state',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
