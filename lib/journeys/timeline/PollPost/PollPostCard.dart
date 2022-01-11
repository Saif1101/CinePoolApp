import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polls/polls.dart';

import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';


import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/poll_post/poll_post_bloc.dart';

class PollPostCard extends StatefulWidget {
  final PollPostModel pollPost;

  const PollPostCard(this.pollPost);


  @override
  _PollPostCardState createState() => _PollPostCardState();
}

class _PollPostCardState extends State<PollPostCard> {
  PollPostBloc pollPostBloc;

  @override
  void initState() {
    super.initState();
    print(widget.pollPost);
    pollPostBloc = getItInstance<PollPostBloc>();
    pollPostBloc.add(LoadPollPostEvent(widget.pollPost));
  }

  @override
  void dispose() {
    super.dispose();
    pollPostBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider<PollPostBloc>(
        create: (context) => pollPostBloc,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ThemeColors.vulcan,
          ),

          child: Padding(
            padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 16.0,
                top: 16.0
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<PollPostBloc, PollPostState>(
                  builder: (context, state) {
                    if(state is PollPostLoaded){
                     return  Column(
                       mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                    backgroundImage:
                                    CachedNetworkImageProvider(
                                      state.postOwner.photoUrl,
                                    ),
                                    radius: 32),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.postOwner.username,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: Sizes.dimen_8.h,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "is hosting a poll",
                                          style: TextStyle(
                                            fontSize: Sizes.dimen_6.h,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                         Divider(color: Colors.white,thickness: 2,),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: FittedBox(
                             fit: BoxFit.fitWidth,
                             child: Text(
                               '${widget.pollPost.title}',
                               style: TextStyle(
                                   fontWeight: FontWeight.w300,
                                   color: Colors.white,
                                   fontSize: Sizes.dimen_8.h
                               ),

                             ),
                           ),
                         ),
                       ],
                     ); //
                  }
                    else if(state is PollPostLoading || state is PollPostInitial){
                      return Center(
                        child: RadiantGradientMask( child: CircularProgressIndicator()),
                      );
                    }
                    return Center(child: Text('Undefined state in PollPost; $state'));
                  },
                ), //Post Header
                BlocBuilder<PollPostBloc, PollPostState>(
                  builder: (BuildContext context, state) {
                    if(state is PollPostLoaded){
                      List pollOptions = [];
                      for(int i =0; i<state.movies.length; i++){
                        pollOptions.add(Polls.options(title: state.movies.elementAt(i).title,
                            value: state.pollOptionsMap[state.movies.elementAt(i).movieID.toString()].toDouble()));
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Polls(
                                question: Text(''),
                                  children: pollOptions,
                                  currentUser: FirestoreConstants.currentUserId,
                                  creatorID: state.postOwner.id+'*',
                                  voteData: state.votersMap,
                                  userChoice: state.votersMap[FirestoreConstants.currentUserId],
                                  onVoteBackgroundColor: Colors.blue,
                                  leadingBackgroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                              onVote: (choice){
                                state.votersMap[FirestoreConstants.currentUserId] = state.movies.elementAt(choice-1).movieID;
                                    state.pollOptionsMap[state.movies.elementAt(choice-1).movieID.toString()]+=1;
                                    BlocProvider.of<PollPostBloc>(context).add(UpdatePollsEvent(
                                      movies: state.movies,
                                        owner : state.postOwner,
                                        postID: widget.pollPost.postID,
                                        votersMap: state.votersMap,
                                        pollOptionsMap: state.pollOptionsMap)
                                    );

                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if(state is PollPostLoading|| state is PollPostInitial){
                      return SizedBox.shrink();
                    }
                    return Center(child: Text('Undefined state in PollPost; $state'));
                  },

                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}
