import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_participation/watch_along_participation_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_post/watch_along_post_bloc.dart';
import 'package:socialentertainmentclub/common/extensions/string_extensions.dart';

class WatchAlongCard extends StatefulWidget {
  final WatchAlong watchAlong;

  WatchAlongCard(this.watchAlong);

  @override
  _WatchAlongCardState createState() => _WatchAlongCardState();
}

class _WatchAlongCardState extends State<WatchAlongCard> {
  WatchAlongPostBloc watchAlongPostBloc;
  WatchAlongParticipationBloc watchAlongParticipationBloc;

  @override
  void initState() {
    super.initState();
    watchAlongPostBloc = getItInstance<WatchAlongPostBloc>();
    watchAlongParticipationBloc =
        watchAlongPostBloc.watchAlongParticipationBloc;
    watchAlongPostBloc.add(LoadWatchAlongEvent(widget.watchAlong));
  }

  @override
  void dispose() {
    super.dispose();
    watchAlongPostBloc?.close();
    watchAlongParticipationBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchAlongPostBloc>(
          create: (context) => watchAlongPostBloc,
        ),
        BlocProvider<WatchAlongParticipationBloc>(
          create: (context) => watchAlongParticipationBloc,
        ),
      ],
      child: BlocBuilder<WatchAlongPostBloc, WatchAlongPostState>(
        builder: (context, state) {
          print("Inside WatchAlongPost Builder : current state is $state");
          if (state is WatchAlongPostLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.vulcan,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      state.watchAlongPostModel.user.photoUrl,
                                    ),
                                    radius: 32),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${state.watchAlongPostModel.user.username}",
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
                                          "is scheduling a watch along",
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
                              Expanded(
                                flex: 1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 20.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 26,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              state.watchAlongPostModel
                                                  .watchAlong.scheduledTime
                                                  .toString()
                                                  .getDateFromTimestamp(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              state.watchAlongPostModel
                                                  .watchAlong.scheduledTime
                                                  .toString()
                                                  .getTimeFromTimestamp(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ), //HeaderRow
                          BlocBuilder<WatchAlongParticipationBloc,
                              WatchAlongParticipationState>(
                            builder: (context, state) {
                              if (state is IsParticipating) {
                                return Divider(
                                  color: state.isParticipating
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  thickness: 4.0,
                                );
                              }
                              return Divider(
                                color: Colors.white,
                                thickness: 4.0,
                              );
                            },
                          ), //GradientDivider
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.0,
                              right: 2.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(12)),
                                            child: Image(
                                                image: CachedNetworkImageProvider(
                                                    '${ApiConstants.BASE_IMAGE_URL}${state.watchAlongPostModel.movieDetailEntity.posterPath}'),
                                                fit: BoxFit.contain,
                                                height: 240),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "${state.watchAlongPostModel.movieDetailEntity.title}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: Sizes.dimen_6.h),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ), //MoviePoster
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 2.0, right: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${state.watchAlongPostModel.watchAlong.title}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: Sizes.dimen_8.h),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.0, top: 4.0),
                                          child: Text(
                                            "Where: ${state.watchAlongPostModel.watchAlong.location}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: Sizes.dimen_6.h),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ), //Information
                              ],
                            ),
                          ), //Body: Poster,Movie-Title, Title, Links
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<WatchAlongParticipationBloc,
                      WatchAlongParticipationState>(
                    builder: (context, state) {
                      if (state is IsParticipating) {
                        return GestureDetector(
                          onTap: () =>
                              BlocProvider.of<WatchAlongParticipationBloc>(
                                      context)
                                  .add(ToggleParticipationEvent(
                                watchAlong: widget.watchAlong,
                                      isParticipating: state.isParticipating)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: state.isParticipating
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12))),
                            //Colors.greenAccent for opted in and Icons.beenhere_outlined with white color

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  state.isParticipating
                                      ? Icons.emoji_emotions_outlined
                                      : Icons.beenhere_outlined,
                                  color: state.isParticipating
                                      ? Colors.black
                                      : Colors.white,
                                  size: 48,
                                ),
                                Text(
                                  state.isParticipating
                                      ? 'You\'re in'
                                      : 'Opt in',
                                  style: TextStyle(
                                    color: state.isParticipating
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: Sizes.dimen_6.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (state is ParticipationButtonLoading ||
                          state is WatchAlongParticipationInitial) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))),
                          //Colors.greenAccent for opted in and Icons.beenhere_outlined with white color
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RadiantGradientMask(
                                  child: CircularProgressIndicator())
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                            "Undefined state in WatchAlongParticipationBloc"),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is WatchAlongPostLoading ||
              state is WatchAlongPostInitial) {
            return Card(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Center(
              child: Text(
            'Undefined state in WatchAlongCard $state',
            style: TextStyle(color: Colors.white),
          ));
        },
      ),
    );
  }
}
