import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

class NewFollowerActivityTile extends StatelessWidget {
  final NewFollowerActivity newFollowerActivity;


  const NewFollowerActivityTile({Key key, @required this.newFollowerActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeColors.primaryColor.withOpacity(0.4),
      elevation: 8.0,
      child: ListTile(
        leading: CircleAvatar(
          radius: Sizes.dimen_8.h,
          backgroundImage: newFollowerActivity.userPhotoURL != null
              ? CachedNetworkImageProvider(
                 newFollowerActivity.userPhotoURL,
                )
              : Image.asset(
                  'assets/images/FreeVector-Sync-Slate.jpg',
                  width: 80,
                ),
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
            fontSize: Sizes.dimen_6.h,
            color: Colors.white,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${newFollowerActivity.username}",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
            ),),
            TextSpan(
              text: " just started following you. ",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
            ),)

          ]
          )
        ),
      ),
    );
  }
}

class AddVoteRecommendationActivityTile extends StatelessWidget {
  final VoteRecommendActivity voteRecommendActivity;

  AddVoteRecommendationActivityTile({@required this.voteRecommendActivity, FeedActivityItem feedActivityItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: ThemeColors.primaryColor.withOpacity(0.4),
      child: ListTile(
     
        leading: CircleAvatar(
          radius: Sizes.dimen_8.h,
          backgroundImage: voteRecommendActivity.userPhotoURL != null
              ? CachedNetworkImageProvider(
                 voteRecommendActivity.userPhotoURL,
                )
              : Image.asset(
                  'assets/images/FreeVector-Sync-Slate.jpg',
                  width: 80,
                ),
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
            fontSize: Sizes.dimen_6.h,
            color: Colors.white,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${voteRecommendActivity.username}",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
            ),),
            TextSpan(
              text: voteRecommendActivity.type == "VoteAdded"?" just cast his vote in ":" just added a recommendation to ",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
            ),),
            TextSpan(
              text: "${voteRecommendActivity.postTitle}",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
            ),),

          ]
          )
        ),
      ),
    );
  }
}

class OptedInToWatchAlongActivityTile extends StatelessWidget {
  final OptedInToWatchAlongActivity optedInToWatchAlongActivity; 

  const OptedInToWatchAlongActivityTile({@required this.optedInToWatchAlongActivity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: ThemeColors.primaryColor.withOpacity(0.4),
      child: ListTile(
        leading: CircleAvatar(
          radius: Sizes.dimen_8.h,
          backgroundImage: optedInToWatchAlongActivity.userPhotoURL != null
              ? CachedNetworkImageProvider(
                 optedInToWatchAlongActivity.userPhotoURL,
                )
              : Image.asset(
                  'assets/images/FreeVector-Sync-Slate.jpg',
                  width: 80,
                ),
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
            fontSize: Sizes.dimen_6.h,
            color: Colors.white,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${optedInToWatchAlongActivity.username}",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
            ),),
            TextSpan(
              text: " opted-in to ",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
            ),),
            TextSpan(
              text: "${optedInToWatchAlongActivity.postTitle}",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
            ),),

          ]
          )
        ),
      ),
    );
  }
}
