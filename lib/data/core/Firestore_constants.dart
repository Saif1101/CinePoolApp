import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:socialentertainmentclub/models/UserModel.dart';

class FirestoreConstants {
  static FirestoreConstants _instance;

  static CollectionReference _usersRef;
  static CollectionReference _followersRef;
  static CollectionReference _followingRef;
  static CollectionReference _favoritesRef;
  static CollectionReference _activityFeedRef; 

  static CollectionReference _watchAlongRef;

  static CollectionReference _watchAlongParticipantsRef;

  static CollectionReference _timelineRef;
  static CollectionReference _pollPostsRef;
  static CollectionReference _recommendationPostsRef;

  static UserModel _currentUser;

  static String _currentUserId;
  static String _currentUsername;
  static String _currentEmail;
  static String _currentPhotoUrl;
  static String _currentDisplayName;
  static Map<String, String> _currentGenres;
  static String _currentTimestamp;


  factory FirestoreConstants() {
    return _instance;
  }

  FirestoreConstants._();

  static void getCurrentUser(UserModel currentUser){
    _currentUser = currentUser;
    _currentUserId = currentUser.id;
    _currentUsername= currentUser.username;
    _currentEmail= currentUser.email;
    _currentPhotoUrl= currentUser.photoUrl;
    _currentDisplayName= currentUser.displayName;
    _currentGenres= currentUser.genres;
    _currentTimestamp= currentUser.timestamp;
  }

  static void setUsernameAndGenres(String username,Map<String,String> genres){
    _currentUser = UserModel.copyWithEditProfile(currentUser:  _currentUser, username: username, genres: genres);
  }

  static void init(){
    if(_instance == null) {
      _instance = FirestoreConstants._();
    }
     _usersRef = FirebaseFirestore.instance.collection('users');

    _favoritesRef= FirebaseFirestore.instance.collection('favorites');
    _followersRef= FirebaseFirestore.instance.collection('followers');
    _followingRef= FirebaseFirestore.instance.collection('following');
    _timelineRef= FirebaseFirestore.instance.collection('timeline');
    _activityFeedRef = FirebaseFirestore.instance.collection('ActivityFeed');

    _watchAlongRef= FirebaseFirestore.instance.collection('WatchAlongs');
    _watchAlongParticipantsRef= FirebaseFirestore.instance.collection('WatchAlongParticipants');

    _pollPostsRef = FirebaseFirestore.instance.collection('PollPosts');
    _recommendationPostsRef = FirebaseFirestore.instance.collection('RecommendationPosts');
  }

  //Access the user id from the info passed to the pages

static CollectionReference get usersRef => _usersRef;
static CollectionReference get favoritesRef => _favoritesRef;
static CollectionReference get followersRef => _followersRef;
static CollectionReference get followingRef => _followingRef;
static CollectionReference get watchAlongRef => _watchAlongRef;
static CollectionReference get watchAlongParticipantsRef => _watchAlongParticipantsRef;
static CollectionReference get timelineRef => _timelineRef;
static CollectionReference get pollPostsRef => _pollPostsRef;
static CollectionReference get recommendationPostsRef => _recommendationPostsRef;
static CollectionReference get activityFeedRef => _activityFeedRef; 

static String get currentUsername => _currentUsername;
static String get currentUserId => _currentUserId;
 static String get currentEmail =>  _currentEmail;
 static String get  currentPhotoUrl => _currentPhotoUrl;
 static Map<String,String> get currentGenres => _currentGenres;
 static String get  currentDisplayName => _currentDisplayName;
 static String get currentUserTimestamp => _currentTimestamp;

static UserModel get currentUser => _currentUser;


}