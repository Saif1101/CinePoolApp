import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/entities/NavigateRecommendationPollParams.dart';
import 'package:socialentertainmentclub/entities/movie_detail_entity.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/profile_screen/user_profile/profile_genre_tags_grid.dart';
import 'package:socialentertainmentclub/journeys/timeline/AskForRecommendationsPost/MovieRecommendationTile.dart';

import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/presentation/blocs/ask_for_recommendations_post/ask_for_recommendations_post_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/ask_for_recommendations_post_list/ask_for_recommendations_post_list_bloc.dart';

class AskForRecommendationsCard extends StatefulWidget {
  final AskForRecommendationsPostModel askForRecommendationsPost;

  const AskForRecommendationsCard(this.askForRecommendationsPost);

  @override
  _AskForRecommendationsCardState createState() =>
      _AskForRecommendationsCardState();
}

class _AskForRecommendationsCardState extends State<AskForRecommendationsCard> {
  AskForRecommendationsPostBloc askForRecommendationsPostBloc;
  AskForRecommendationsPostListBloc askForRecommendationsPostListBloc;

  @override
  void initState() {
    super.initState();
    askForRecommendationsPostBloc =
        getItInstance<AskForRecommendationsPostBloc>();

    askForRecommendationsPostListBloc =
        getItInstance<AskForRecommendationsPostListBloc>();

    askForRecommendationsPostBloc.add(
        LoadAskForRecommendationsPostEvent(widget.askForRecommendationsPost));

    askForRecommendationsPostListBloc.add(LoadRecommendationsPostListEvent(
        recommendationsTrackMap:
            widget.askForRecommendationsPost.recommendationsTrackMap,
        postID: widget.askForRecommendationsPost.postID,
        ownerID: widget.askForRecommendationsPost.ownerID));
  }

  @override
  void dispose() {
    super.dispose();
    askForRecommendationsPostListBloc?.close();
    askForRecommendationsPostBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AskForRecommendationsPostListBloc>(
            create: (context) => askForRecommendationsPostListBloc,
          ),
          BlocProvider<AskForRecommendationsPostBloc>(
            create: (context) => askForRecommendationsPostBloc,
          ),
        ],
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: ThemeColors.vulcan,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AskForRecommendationsPostBloc, AskForRecommendationsPostState>(
                  builder: (context, state) {
                    if (state is AskForRecommendationsPostLoaded) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            bottom: 16.0,
                            top: 16.0
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                                            "is asking for recommendations",
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

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  '${state.askForRecommendationsPost.body}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: Sizes.dimen_8.h
                                  ),

                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GenreTagsHorizontalScroll(
                                leftTitleWeight: FontWeight.bold,
                                titleColor: Colors.white,
                                  scrollBgColor: ThemeColors.vulcan,
                                  genres: state.askForRecommendationsPost
                                      .preferredGenres,
                                  leftTitle: "Preferred Genres"),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),//GenreTags
                          ],
                        ),
                      );
                    } else if (state is AskForRecommendationsPostLoading) {
                      return Center(
                        child: RadiantGradientMask(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Center(
                        child: Text(
                            'Undefined state inside AskForRecommendationsCard $state'));
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: BlocBuilder<AskForRecommendationsPostListBloc,
                          AskForRecommendationsPostListState>(
                      builder: (context, state) {
                    if (state is AskForRecommendationsPostListLoaded) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: state.users.containsKey(
                                    FirestoreConstants.currentUserId)
                                    ? Colors.blueAccent
                                    : Colors.white,
                                    thickness: 2.0,

                                  ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: state.users.containsKey(
                                                FirestoreConstants.currentUserId)
                                            ? Text(
                                                'Recommendation Added',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500))
                                            : Text('Add Recommendations',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500)),
                                      ),
                                      state.users.containsKey(
                                              FirestoreConstants.currentUserId)
                                          ? SizedBox.shrink()
                                          : RadiantGradientMask(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () => {
                                                  Navigator.of(context).pushNamed(
                                                      RouteList
                                                          .addRecommendationPage,
                                                      arguments: NavigateRecommendationsPollParams(
                                                          blocName:
                                                              'RecommendationsPost',
                                                          askForRecommendationsPostListBloc:
                                                              askForRecommendationsPostListBloc))
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                color: state.users.containsKey(
                                    FirestoreConstants.currentUserId)
                                    ? Colors.blueAccent
                                    : Colors.white,
                                    thickness: 2.0,
                              )
                              ),
                            ],
                          ),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.movies.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 2,
                                );
                              },
                              itemBuilder: (context, index) {
                                MovieDetailEntity movie =
                                    state.movies.values.toList()[index];
                                return MovieRecommendationTile(
                                  movie: movie,
                                  users: state.movieUserMap[movie.movieID.toString()],
                                  onTap: () {
                                    BlocProvider.of<
                                                AskForRecommendationsPostListBloc>(
                                            context)
                                        .add(
                                            RemoveRecommendationFromPostListEvent(
                                                ownerID: state.ownerID,
                                                movieID: movie.movieID.toString(),
                                                recommendationsTrackMap: state.recommendationsTrackMap,
                                                movies: state.movies,
                                                movieUserMap: state.movieUserMap,
                                                postID: state.postID,
                                                users: state.users));
                                  },
                                );
                              })
                        ],
                      );
                    } else if (state is AskForRecommendationsPostListLoading) {
                      return Center(
                          child: RadiantGradientMask(
                            child: CircularProgressIndicator(),
                          ));
                    }
                    return Center(
                      child: Text(
                          "Undefined state in AskForRecommendationsPostListBloc: Header: $state"),
                    );
                  }), //
                )
              ],
            ),
          ),
        ));
  }
}
