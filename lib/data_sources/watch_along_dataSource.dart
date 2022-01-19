
/*
collection  / doc  / col       / doc   / col             /         doc
WatchAlongs /userID/WatchAlongs/MovieID/MovieWatchAlongs/WatchAlongID/WatchAlongEntitiy

collection            /         doc /   collection    / doc
WatchAlongParticipants/WatchAlongID/    Participants  / userIDs
*/



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';


abstract class WatchAlongDataSource{
  Future<void> deleteWatchAlong(String movieID, String watchAlongID);
  Future <bool> checkWatchAlong(String movieID);
  Future <void> createWatchAlong(WatchAlong watchAlong);
  Future <void> removeWatchAlong(String movieID);
  Future <void> optIntoWatchAlong(WatchAlong watchAlong);
  Future <void> optOutOfWatchAlong(WatchAlong watchAlong);
  Future <bool> checkIfParticipant(String watchAlongID);//Add WatchAlongParticipants/WatchAlongID/UserID
  Future <List<WatchAlong>> getMyWatchAlongs();
}

class WatchAlongDataSourceImpl extends WatchAlongDataSource{

  @override
  Future<bool> checkWatchAlong(movieID) async {
    DocumentSnapshot doc = await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('WatchAlongs')
    .doc(movieID)
    .get();
    
    if(doc.exists){
      return true;
    }
    return false;
  }

  @override
  Future<void> createWatchAlong(WatchAlong watchAlong) async {

    String id = FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId)
        .collection('WatchAlongs')
        .doc()
        .id;

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('WatchAlongs')
        .doc(watchAlong.movieID)
        .set({
      'type': 'WatchAlong',
      'location': watchAlong.location,
      'watchAlongID':id,
      'movieID': watchAlong.movieID,
      'ownerID': FirestoreConstants.currentUserId,
      'title':watchAlong.title,
      'scheduledTime':watchAlong.scheduledTime,
    });
  }


  @override
  Future<void> removeWatchAlong(movieID) async {

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('WatchAlongs')
        .doc(movieID)
        .collection('MovieWatchAlongs')
        .get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
    }
    });
  }

  @override
  Future<void> optIntoWatchAlong(WatchAlong watchAlong) async {

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('MyWatchAlongs')
        .doc(watchAlong.watchAlongID)
        .set({
      'type': 'WatchAlong',
      'location': watchAlong.location,
      'watchAlongID':watchAlong.watchAlongID,
      'movieID': watchAlong.movieID,
      'ownerID': FirestoreConstants.currentUserId,
      'title':watchAlong.title,
      'scheduledTime':watchAlong.scheduledTime,}
    );


    await FirestoreConstants
        .watchAlongParticipantsRef
        .doc(watchAlong.watchAlongID)
        .collection('Participants')
        .doc(FirestoreConstants.currentUserId.toString())
        .set({});
  }

  @override
  Future<void> optOutOfWatchAlong(WatchAlong watchAlong) async {

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('MyWatchAlongs')
        .doc(watchAlong.watchAlongID)
        .delete();

    await FirestoreConstants.watchAlongParticipantsRef.doc(watchAlong.watchAlongID)
        .collection('Participants')
        .doc(FirestoreConstants.currentUserId.toString())
        .delete();
  }

  @override
  Future<bool> checkIfParticipant(String watchAlongID) async {
    DocumentSnapshot doc = await FirestoreConstants.watchAlongParticipantsRef.doc(watchAlongID)
        .collection('Participants')
        .doc(FirestoreConstants.currentUserId.toString())
        .get();
    if(doc.exists){
      return true;
    }
    return false;
  }

  @override
  Future<List<WatchAlong>> getMyWatchAlongs() async {

    List<WatchAlong> myWatchAlongs = [];

    QuerySnapshot snapshot = await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId)
        .collection('MyWatchAlongs')
        .get();
    
    QuerySnapshot snapshot2 = await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId)
        .collection('WatchAlongs')
        .get();

    if(snapshot.docs.length>0){
      snapshot.docs.forEach((doc) {
        myWatchAlongs.add(WatchAlong.fromDocument(doc));
      });
    }

    if(snapshot2.docs.length>0){
      snapshot2.docs.forEach((doc) {
        myWatchAlongs.add(WatchAlong.fromDocument(doc));
      });
    }

    return myWatchAlongs;

  }

  @override
  Future<void> deleteWatchAlong(String movieID, String watchAlongID) async {
    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('WatchAlongs')
        .doc(movieID)
    .collection('MovieWatchAlongs')
    .doc(watchAlongID)
        .delete();
  }
}

