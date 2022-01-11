import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

abstract class UserActionsRemoteDataSource{
  Future<void> addFollowerAndFollowing(String userID);
  Future<int> getFollowers(String userID);
  Future<int>getFollowing(String userID);
  Future<void> unfollowUser(String userID);
  Future<bool> checkIfFollowing(String userID);
  Future<List<UserModel>> getSearchedUsers(String searchTerm);
}

class UserActionsRemoteDataSourceImpl extends UserActionsRemoteDataSource{

  @override
  Future <List<UserModel>> getSearchedUsers(String searchTerm) async {
    List<UserModel> userList = [];
    QuerySnapshot users =  await FirestoreConstants.usersRef.where("username", isGreaterThanOrEqualTo: searchTerm).get();
    users.docs.forEach((element) {
      UserModel user = UserModel.fromDocument(element);
      if(user.id!=FirestoreConstants.currentUserId){
        userList.add(user);
      }
    }
    );
    return userList;
  }

  @override
  Future<void> addFollowerAndFollowing(String userID) async {
    print("${FirestoreConstants.currentUserId} is now following $userID");
    await FirestoreConstants.followersRef.doc('$userID').collection('UserFollowers').doc('${FirestoreConstants.currentUserId}').set({});
    await FirestoreConstants.followingRef.doc('${FirestoreConstants.currentUserId}').collection('UserFollowing').doc('$userID').set({});
  }

  @override
  Future<bool> checkIfFollowing(String userID) async {
    //check and return true/false if the currentUser follows userID
    DocumentSnapshot doc = await FirestoreConstants.followersRef.doc('$userID')
        .collection('UserFollowers').doc('${FirestoreConstants.currentUserId}').get();
    return doc.exists;
  }

  @override
  Future<int> getFollowers(String userID) async {
    QuerySnapshot snapshot = await FirestoreConstants.followersRef
        .doc(userID)
        .collection('UserFollowers')
        .get();
    print('$userID has ${snapshot.docs.length} followers ');
    return snapshot.docs.length;
  }

  @override
  Future<int> getFollowing(String userID) async {
    QuerySnapshot snapshot = await FirestoreConstants.followingRef
        .doc(userID)
        .collection('UserFollowing')
        .get();
    print('$userID has ${snapshot.docs.length} following ');
    return snapshot.docs.length;
}

  @override
  Future<void> unfollowUser(String userID) async {
    //Delete reference of currentUser in followers collection of userID.
    FirestoreConstants.followersRef.doc('$userID').collection('UserFollowers')
        .doc('${FirestoreConstants.currentUserId}').delete();

    //Delete reference of userID in following collection of currentUser.
    FirestoreConstants.followersRef.doc('${FirestoreConstants.currentUserId}').collection('UserFollowing')
        .doc('$userID').delete();
  }
}

