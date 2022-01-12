import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/Post.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

/*
collection/  document/ collection/
Timeline/   userID/      Posts/   document
 */

abstract class PostsRemoteDataSource {
 Future <List<Post>> getPosts();
}

class PostsRemoteDataSourceImpl extends PostsRemoteDataSource {

  @override
  Future<List<Post>> getPosts() async {
    List<Post> posts = [];

    QuerySnapshot snapshot = await FirestoreConstants.timelineRef
        .doc(FirestoreConstants.currentUserId)
        .collection('Posts')
        .limit(10)
        .get();

    snapshot.docs.forEach((doc) {
      if(doc.data()['type'] == 'WatchAlong'){
        posts.add(WatchAlong.fromDocument(doc));
      }
      else if(doc.data()['type']=='PollPost'){
        posts.add(PollPostModel.fromDocument(doc));
      }
      else if(doc.data()['type']=='AskForRecommendationsPost'){
        posts.add(AskForRecommendationsPostModel.fromDocument(doc));
      }
    });
    return posts;
  }

}