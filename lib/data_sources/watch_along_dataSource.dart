
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
  Future <String> checkWatchAlong(String movieID); //Return WatchAlongID if scheduled, else return NA
  Future <void> createWatchAlong(WatchAlong watchAlong);
  Future <void> optIntoWatchAlong(WatchAlong watchAlong);
  Future <void> optOutOfWatchAlong(WatchAlong watchAlong);
  Future <bool> checkIfParticipant(String watchAlongID);//Add WatchAlongParticipants/WatchAlongID/UserID
  Future <List<WatchAlong>> getMyWatchAlongs();
  Future<List<String>> getWatchAlongParticipants(String watchAlongID); 
}

class WatchAlongDataSourceImpl extends WatchAlongDataSource{

  @override
  Future<String> checkWatchAlong(movieID) async { 
    // fetch watchAlongID if a WatchAlong has been schedueled so that
    // you can delete it from the movie detail screen too
    DocumentSnapshot doc = await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('MyWatchAlongs')
    .doc(movieID)
    .get();
    
    if(doc.exists){
      return doc.data()['watchAlongID'];
    }
    return 'NA';
  }

  @override
  Future<void> createWatchAlong(WatchAlong watchAlong) async {

    String id = FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId)
        .collection('MyWatchAlongs')
        .doc()
        .id;

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('MyWatchAlongs')
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
  Future<void> deleteWatchAlong(String movieID, String watchAlongID) async {

    print("Delete Path: watchAlongRef/${FirestoreConstants.currentUserId.toString()}/WatchAlongs/$movieID");
    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('MyWatchAlongs')
        .doc(movieID)
        .delete();
        
    await FirestoreConstants.watchAlongParticipantsRef.doc(watchAlongID)
        .delete();
  }

  @override
  Future<void> optIntoWatchAlong(WatchAlong watchAlong) async {

    //Refactored DB

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('OptedInToWatchAlongs')
        .doc(watchAlong.watchAlongID)
        .set({
      'watchAlongID':watchAlong.watchAlongID,
      'movieID': watchAlong.movieID,
      'ownerID': watchAlong.ownerID,
      });


    await FirestoreConstants
        .watchAlongParticipantsRef
        .doc(watchAlong.watchAlongID)
        .collection('Participants')
        .doc(FirestoreConstants.currentUserId.toString())
        .set({});
  }

  @override
  Future<void> optOutOfWatchAlong(WatchAlong watchAlong,) async {

    await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId.toString())
        .collection('OptedInToWatchAlongs')
        .doc(watchAlong.movieID)
        .delete();

    await FirestoreConstants.watchAlongParticipantsRef
        .doc(watchAlong.watchAlongID)
        .collection('Participants')
        .doc(FirestoreConstants.currentUserId.toString())
        .delete();

        //Remove this user's participation from owner's feed 

    await FirestoreConstants.activityFeedRef
          .doc(watchAlong.ownerID)
          .collection('ActivityFeed')
          .doc('${watchAlong.watchAlongID}${FirestoreConstants.currentUserId.toString()}')
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
        .collection('OptedInToWatchAlongs')
        .get();
    
    QuerySnapshot snapshot2 = await FirestoreConstants.watchAlongRef
        .doc(FirestoreConstants.currentUserId)
        .collection('MyWatchAlongs')
        .get();

    if(snapshot.docs.length>0){
      snapshot.docs.forEach((doc) async {

        String ownerID = doc.data()['ownerID'];
        String movieID = doc.data()['movieID'];
        
        DocumentSnapshot watchAlong  = await FirestoreConstants.watchAlongRef
        .doc(ownerID)
        .collection('MyWatchAlongs')
        .doc(movieID)
        .get(); 

        myWatchAlongs.add(WatchAlong.fromDocument(watchAlong));

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
  Future<List<String>> getWatchAlongParticipants(String watchAlongID) async {
    List<String> participantIDs = []; 

    QuerySnapshot snapshot = await FirestoreConstants.watchAlongParticipantsRef
        .doc(watchAlongID)
        .collection('Participants')
        .get();
      
    snapshot.docs.forEach((doc) {
       participantIDs.add(doc.id);
      });
    
    return participantIDs;
  }

  
}

