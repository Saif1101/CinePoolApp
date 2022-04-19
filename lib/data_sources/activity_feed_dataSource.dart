import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';

//interpolating userID and postID to create documentID for ActivityFeed collection so that the feedItem can be deleted from the post too 
// for eg: opt out of watchalong use case should also be able to delete the feed activity. Since every post supports only one interaction from 
// a single user, this ought to work. This will make sure every interaction has a unique feed notification created for it.

abstract class ActivityFeedDataSource{
  Future<void> addVoteActivity(VoteRecommendActivity voteRecommendActivity); 
  Future<void> addRecommendationActivity(VoteRecommendActivity voteRecommendActivity); 
  Future<void> addNewFollowerActivity(NewFollowerActivity newFollowerActivity); 
  Future<void> optIntoWatchAlongActivity(OptedInToWatchAlongActivity optedInToWatchAlongActivity);
  Future<List<FeedActivityItem>> getFeedItems(); 
  Future<void> deleteActivityFromFeed(String feedOwnerID, String activityID); 
}

class ActivityFeedDataSourceImpl extends ActivityFeedDataSource{
  @override
  Future<void> addRecommendationActivity(VoteRecommendActivity voteRecommendActivity) async {
    await FirestoreConstants.activityFeedRef
          .doc(voteRecommendActivity.postOwnerID)
          .collection('ActivityFeed')
          .doc('${voteRecommendActivity.postID}${voteRecommendActivity.actorUserID}')
          .set({
          
            "actorUserID": voteRecommendActivity.actorUserID,
            "postOwnerID": voteRecommendActivity.postOwnerID,
            "type": 'RecommendationAdded', 
            'timestamp': voteRecommendActivity.timestamp,
            'username': FirestoreConstants.currentUsername,
            'userPhotoURL' : FirestoreConstants.currentPhotoUrl, 
            'postID':voteRecommendActivity.postID, 
            'postTitle': voteRecommendActivity.postTitle,
          });
  }

  //Show only the most recent vote activity since the post widget does not show who voted what
  @override
  Future<void> addVoteActivity(VoteRecommendActivity voteRecommendActivity) async {
    await FirestoreConstants.activityFeedRef
          .doc(voteRecommendActivity.postOwnerID)
          .collection('ActivityFeed')
          .doc('${voteRecommendActivity.postID}${voteRecommendActivity.actorUserID}')
          .set({
           
            'postOwnerID':voteRecommendActivity.postOwnerID,
            'actorUserID': voteRecommendActivity.actorUserID,
            "type": 'VoteAdded', 
            'timestamp': voteRecommendActivity.timestamp,
            'username': FirestoreConstants.currentUsername,
            'userPhotoURL' : FirestoreConstants.currentPhotoUrl, 
            'postID': voteRecommendActivity.postID, 
            'postTitle': voteRecommendActivity.postTitle,
          });
  }

  @override
  Future<List<FeedActivityItem>> getFeedItems() async {

    List<FeedActivityItem> feedItems = []; 

    QuerySnapshot query = await FirestoreConstants.activityFeedRef
          .doc(FirestoreConstants.currentUserId)
          .collection('ActivityFeed')
          .get();
    
    if(query.docs.length>0){
      query.docs.forEach(
        (doc) { 
         if(doc['type'] == "VoteAdded" || doc["type"]=="RecommendationAdded"){
           feedItems.add(VoteRecommendActivity.fromDocument(doc));
         } else if (doc['type'] == 'NewFollower'){
           feedItems.add(NewFollowerActivity.fromDocument(doc));
         } else if (doc['type']=='OptedInToWatchAlong'){
           feedItems.add(OptedInToWatchAlongActivity.fromDocument(doc));
         }
            }
        );
    }
    return feedItems;       
  }

  @override
  Future<void> addNewFollowerActivity(NewFollowerActivity newFollowerActivity) async {
    await FirestoreConstants.activityFeedRef
          .doc(newFollowerActivity.followedUserID)
          .collection('ActivityFeed')
          .doc(newFollowerActivity.actorUserID)
          .set({
            "type": newFollowerActivity.type, 
            'timestamp': newFollowerActivity.timestamp,
            'username': newFollowerActivity.username,
            'userPhotoURL' : newFollowerActivity.userPhotoURL, 
            'actorUserID': newFollowerActivity.actorUserID, 
            'followedUserID': newFollowerActivity.followedUserID,
          });
  }

  //Add feed item for everyone who participated in the watchalong 
  @override
  Future<void> optIntoWatchAlongActivity(OptedInToWatchAlongActivity optedInToWatchAlongActivity) async {
    await FirestoreConstants.activityFeedRef
          .doc(optedInToWatchAlongActivity.postOwnerID)
          .collection('ActivityFeed')
          .doc('${optedInToWatchAlongActivity.postID}${optedInToWatchAlongActivity.actorUserID}')
          .set({
            "postOwnerID": optedInToWatchAlongActivity.postOwnerID,
            "actorUserID": optedInToWatchAlongActivity.actorUserID,
            "type": optedInToWatchAlongActivity.type, 
            'movieID': optedInToWatchAlongActivity.movieID,
            'timestamp': optedInToWatchAlongActivity.timestamp,
            'username': optedInToWatchAlongActivity.username,
            'userPhotoURL' : optedInToWatchAlongActivity.userPhotoURL, 
            'postID': optedInToWatchAlongActivity.postID, 
            'postTitle': optedInToWatchAlongActivity.postTitle,
          });
  }

  @override
  Future<void> deleteActivityFromFeed (String feedOwnerID, String activityID) async {
    print("Deletion path: activityFeedRef/$feedOwnerID/ActivityFeed/$activityID");
    
    await FirestoreConstants.activityFeedRef
                              .doc(feedOwnerID)
                              .collection('ActivityFeed')
                              .doc(activityID)
                              .delete();

    
  }
}