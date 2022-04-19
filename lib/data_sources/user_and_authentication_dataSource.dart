import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';



import 'package:socialentertainmentclub/models/UserModel.dart';


abstract class UserAndAuthenticationDataSource{
  Future <void> setUsernameAndGenres(String username, Map<String,String>genres);

  Future <UserModel> getUserFromID(String userID);

  Future<UserModel> newUserSignUp(
      {String id,
        String username,
        String photoUrl,
        String email,
        Map<String, String> selectedGenres,
        String timestamp,
        String displayName}
      );
  Future<List<UserModel>> getRecentUsers(); 

}

class UserAndAuthenticationDataSourceImpl extends UserAndAuthenticationDataSource{


  UserAndAuthenticationDataSourceImpl();

  @override
  Future<void> setUsernameAndGenres(String username, Map<String, String> genres) async {
   await FirestoreConstants.usersRef.doc(FirestoreConstants.currentUserId).update({
      'username': username,
      'genres': genres,
    });
  }

  
  @override
  Future<UserModel> newUserSignUp({String id, String username, String photoUrl, String email, Map<String, String> selectedGenres, String timestamp, String displayName}) async {
    FirestoreConstants.usersRef.doc(id).set({
      'id': id,
      'username': username,
      'photoUrl': photoUrl,
      'email': email,
      'displayName': displayName,
      'genres': selectedGenres,
      'timestamp': timestamp,
    });
    DocumentSnapshot doc =  await FirestoreConstants.usersRef.doc(id).get();
    return UserModel.fromDocument(doc);
  }

  

  

  @override
  Future<UserModel> getUserFromID(userID) async {
    print('Getting user from ID: $userID');
    DocumentSnapshot doc = await FirestoreConstants.usersRef.doc(userID).get();
    return UserModel.fromDocument(doc);
  }

  @override
  Future<List<UserModel>> getRecentUsers() async {
    List<UserModel> users = []; 
    QuerySnapshot userQuery = await FirestoreConstants.usersRef.orderBy('timestamp', descending: true).get();
    userQuery.docs.forEach((doc) {
      users.add(UserModel.fromDocument(doc));
     });
    return users; 
  }
}