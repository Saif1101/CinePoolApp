import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

/*
RecommendationsPoll	/ownerID	UserRecommendationsPost 	/pollPostID

*/

//Make sure no data processing happens here-> only retrieval and updation
//Passing in PROCESSED MAPS for updation
abstract class RecommendationsPollsDataSource {
  //For Poll Post
  Future<void> createPollPost(PollPostModel pollPost);

  Future<void> deletePollPost(String postID);

  Future<List<PollPostModel>> getMyPollPosts();

  Future<void> castPollVote({
    Map<String, int> pollOptionsMap,
    Map<String, int> votersMap,
    String ownerID,
    String postID,
  });

  //For Recommendations Post
  Future<void> createRecommendationsPost(
      AskForRecommendationsPostModel askForRecommendationsPostModel);

  Future<List<AskForRecommendationsPostModel>> getMyAskForRecommendationPosts();

  Future<void> updateRecommendationsTrackMap(
    Map<String, List<String>> recommendationsTrackMap,
    String ownerID,
    String postID,
  );

  Future<void> deleteRecommendationPost(String postID);
}

class RecommendationsPollsDataSourceImpl
    extends RecommendationsPollsDataSource {
  //For Recommendations
  @override
  Future<List<AskForRecommendationsPostModel>>
      getMyAskForRecommendationPosts() async {
    List<AskForRecommendationsPostModel> myAskForRecommendationsPosts = [];

    print('fetching my recommendations post');

    QuerySnapshot snapshot = await FirestoreConstants.recommendationPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserRecommendationPosts')
        .get();

    if (snapshot.docs.length > 0) {
      snapshot.docs.forEach((doc) {
        myAskForRecommendationsPosts
            .add(AskForRecommendationsPostModel.fromDocument(doc));
      });
    }

    return myAskForRecommendationsPosts;
  }

  @override
  Future<void> updateRecommendationsTrackMap(
      Map<String, List<String>> recommendationsTrackMap,
      String ownerID,
      String postID) async {
    print(
        "Updating new track map $recommendationsTrackMap to $ownerID and postID: $postID");

    await FirestoreConstants.recommendationPostsRef
        .doc(ownerID)
        .collection('UserRecommendationPosts')
        .doc(postID)
        .update({
      'recommendationsTrackMap': recommendationsTrackMap,
    });

    await FirestoreConstants.timelineRef
        .doc(FirestoreConstants.currentUserId)
        .collection('Posts')
        .doc(postID)
        .update({
      'recommendationsTrackMap': recommendationsTrackMap,
    });
  }

  @override
  Future<void> createRecommendationsPost(
      AskForRecommendationsPostModel askForRecommendationsPost) async {
        print('Inside datasource');
    String id = FirestoreConstants.recommendationPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserRecommendationPosts')
        .doc()
        .id;

    await FirestoreConstants.recommendationPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserRecommendationPosts')
        .doc(id)
        .set({
      'type': askForRecommendationsPost.type,
      'postID': id,
      'title': askForRecommendationsPost.title,
      'ownerID': FirestoreConstants.currentUserId,
      'preferredGenres' : askForRecommendationsPost.preferredGenres,
      'recommendationsTrackMap': askForRecommendationsPost.recommendationsTrackMap,
    });
  }

  @override
  Future<void> deleteRecommendationPost(String postID) async {
    await FirestoreConstants.recommendationPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserRecommendationPosts')
        .doc(postID)
        .delete();
  }

  //For PollPosts
  @override
  Future<List<PollPostModel>> getMyPollPosts() async {
    List<PollPostModel> myPollPosts = [];

    QuerySnapshot snapshot = await FirestoreConstants.pollPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserPollPosts')
        .get();

    if (snapshot.docs.length > 0) {
      snapshot.docs.forEach((doc) {
        myPollPosts.add(PollPostModel.fromDocument(doc));
      });
    }

    return myPollPosts;
  }

  @override
  Future<void> createPollPost(PollPostModel pollPost) async {
    String id = FirestoreConstants.pollPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserPollPosts')
        .doc()
        .id;

    await FirestoreConstants.pollPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserPollPosts')
        .doc(id)
        .set({
      'type': 'PollPost',
      'postID': id,
      'title': pollPost.title,
      'pollOptionsMap': pollPost.pollOptionsMap,
      'ownerID': FirestoreConstants.currentUserId,
      'votersMap': pollPost.votersMap,
    });
  }

  @override
  Future<void> deletePollPost(String postID) async {
    await FirestoreConstants.pollPostsRef
        .doc(FirestoreConstants.currentUserId)
        .collection('UserPollPosts')
        .doc(postID)
        .delete();
  }

  @override
  Future<void> castPollVote({
    Map<String, int> pollOptionsMap,
    Map<String, int> votersMap,
    String ownerID,
    String postID,
  }) async {
    await FirestoreConstants.pollPostsRef
        .doc(ownerID)
        .collection('UserPollPosts')
        .doc(postID)
        .update({'pollOptionsMap': pollOptionsMap, 'votersMap': votersMap});

    await FirestoreConstants.timelineRef
        .doc(FirestoreConstants.currentUserId)
        .collection('Posts')
        .doc(postID)
        .update({'pollOptionsMap': pollOptionsMap, 'votersMap': votersMap});
  }
}
