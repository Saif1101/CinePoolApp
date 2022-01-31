import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';



abstract class PostFromFeedDataSource {
  Future<WatchAlong> fetchWatchAlong(String ownerID, String movieID); 
  Future<AskForRecommendationsPostModel> fetchRecommendationPost(String ownerID, String postID); 
  Future<PollPostModel> fetchPollPost(String ownerID, String postID); 
}

class PostFromFeedDataSourceImpl extends PostFromFeedDataSource{
  @override
  Future<PollPostModel> fetchPollPost(String ownerID, String postID) async {
    final doc = await FirestoreConstants.pollPostsRef
                            .doc(ownerID)
                            .collection('UserPollPosts')
                            .doc(postID)
                            .get();
    if(doc.exists){
      PollPostModel post = PollPostModel.fromDocument(doc); 
      return post; 
    }
    return null;
  }

  @override
  Future<AskForRecommendationsPostModel> fetchRecommendationPost(String ownerID, String postID) async {

    final doc = await FirestoreConstants.recommendationPostsRef
                            .doc(ownerID).collection('UserRecommendationPosts')
                            .doc(postID)
                            .get();
    if(doc.exists){
      AskForRecommendationsPostModel post =AskForRecommendationsPostModel.fromDocument(doc); 
      return post;
    }
    return null;
  }

  @override
  Future<WatchAlong> fetchWatchAlong(String ownerID, String movieID) async {
    final doc = await FirestoreConstants.watchAlongRef
                .doc(ownerID)
                .collection('MyWatchAlongs')
                .doc(movieID)
                .get();
    
    if(doc.exists){
      WatchAlong post = WatchAlong.fromDocument(doc);
      return post;
    }
    return null;
  }
  
}