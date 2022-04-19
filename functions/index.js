const functions = require("firebase-functions");
const admin =  require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


//To delete the posts of the user you just unfollowed. 
// ->When User1 unfollows User2 
// /followers/User2/UserFollowers/User1 gets deleted 
// /following/User1/UserFollowing/User2 gets deleted
// Delete  User2's posts from User1's timeline 
exports.onDeleteFollower = functions.firestore.document("/followers/{userID}/UserFollowers/{followerID}")
.onDelete(async (snapshot,context)=>{
      console.log("Follower Deleted"),context.params.followerID;
      const userID = context.params.userID; 
      const followerID = context.params.followerID; 
      const timelinePostsRef = admin.firestore()
                                    .collection("timeline")
                                    .doc(followerID)
                                    .collection("Posts")
                                    .where("ownerID","==",userID);
                                                        
                                const posts = await timelinePostsRef.get(); 
                                posts.forEach(doc=>{
                                    if(doc.exists){
                                        doc.ref.delete(); 
                                    }
        })
 })
    
    //To add the created Watch-Along Post to every followers timeline 
exports.onCreateWatchAlong = functions.firestore.document('/WatchAlongs/{userID}/MyWatchAlongs/{movieID}')
        .onCreate(async(snapshot,context)=>{
            const postCreated = snapshot.data(); 
            const userID = context.params.userID;
            
            //Getting all the followers of the user who created the post. 
            const userFollowersRef = admin.firestore()
                    .collection('followers')
                    .doc(userID)
                    .collection('UserFollowers');
                    
            const followers =  await userFollowersRef.get(); 
            
            followers.forEach(doc=>{
                const followerID = doc.id; 
                admin
                    .firestore()
                    .collection('timeline')
                    .doc(followerID)
                    .collection('Posts')
                    .doc(postCreated.watchAlongID)
                    .set(postCreated); 
            })
        })
        
    //To add the newly created RecommendationPost to every followers timeline
    
exports.onCreateRecommendationPost = functions.firestore
        .document('/RecommendationPosts/{userID}/UserRecommendationPosts/{recommendationPostID}')
        .onCreate(async(snapshot,context)=>{
            const postCreated = snapshot.data(); 
            const userID = context.params.userID;
            const recommendationPostID = context.params.recommendationPostID;
            
            //Getting all the followers of the user who created the post. 
            const userFollowersRef = admin.firestore()
                    .collection('followers')
                    .doc(userID)
                    .collection('UserFollowers');
                    
            const followers =  await userFollowersRef.get(); 
            
            followers.forEach(doc=>{
                const followerID = doc.id; 
                
                admin
                    .firestore()
                    .collection('timeline')
                    .doc(followerID)
                    .collection('Posts')
                    .doc(recommendationPostID)
                    .set(postCreated); 
            })
        })
    
    //To add the newly created RecommendationPost to every followers timeline
    
    exports.onCreatePollPost = functions.firestore
        .document('/PollPosts/{userID}/UserPollPosts/{pollPostID}')
        .onCreate(async(snapshot,context)=>{
            const postCreated = snapshot.data(); 
            const userID = context.params.userID;
            const pollPostID = context.params.pollPostID;
            
            //Getting all the followers of the user who created the post. 
            const userFollowersRef = admin.firestore()
                    .collection('followers')
                    .doc(userID)
                    .collection('UserFollowers');
                    
            const querySnapshot =  await userFollowersRef.get(); 
            
            querySnapshot.forEach(doc=>{
                const followerID = doc.id; 
                
                admin
                    .firestore()
                    .collection('timeline')
                    .doc(followerID)
                    .collection('Posts')
                    .doc(pollPostID)
                    .set(postCreated); 
            })
        })

exports.onDeleteWatchAlong = functions.firestore
        .document('/WatchAlongs/{userID}/MyWatchAlongs/{movieID}')
        .onDelete(async(snapshot,context)=>{
            const userID = context.params.userID;
            const watchAlongID = snapshot.watchAlongID;
            const movieID = context.params.movieID;
            
            // Get all participants' ID
            const watchAlongParticipantsRef = admin.firestore()
                        .collection('WatchAlongParticipants')
                        .doc(watchAlongID)
                        .collection('Participants');

            
            const participants = await watchAlongParticipantsRef.get();
            
            participants.forEach(async doc=>{
                const watchAlongParticipationRef =admin.firestore()
                            .collection('WatchAlongs')
                            .doc(doc.id)
                            .collection('OptedInToWatchAlongs')
                            .where('watchAlongID','==',watchAlongID);
                
                const participationDoc = await watchAlongParticipationRef.get(); 
                                participationDoc.forEach(doc2=>{
                                    if(doc2.exists){
                                        doc2.ref.delete(); 
                                    }
                                })
                
            })

            //Deleting the WatchAlongs from the followers' timeline 
            const userFollowersRef = admin.firestore()
                    .collection('followers')
                    .doc(userID)
                    .collection('UserFollowers');
            
                    const followers =  await userFollowersRef.get(); 
            
                    followers.forEach( doc=>{
                        const followerID = doc.id;  
                        admin
                            .firestore()
                            .collection('timeline')
                            .doc(followerID)
                            .collection('Posts')
                            .doc(watchAlongID)
                            .delete();
                        
                        admin
                            .firestore()
                            .collection('WatchAlongs')
                            .doc(followerID)
                            .collection('OptedInToWatchAlongs')
                            .doc(watchAlongID)
                            .delete();
                    })
            
            

            
            
        })

exports.onDeleteRecommendationsPost = functions.firestore.document("/RecommendationPosts/{ownerID}/UserRecommendationPosts/{postID}")
        .onDelete(async (snapshot,context)=>{
              const ownerID = context.params.ownerID; 
              const postID = context.params.postID; 

              const userFollowersRef = admin.firestore()
              .collection('followers')
              .doc(ownerID)
              .collection('UserFollowers');
      
              const followers =  await userFollowersRef.get(); 
      
              followers.forEach( doc=>{
                  const followerID = doc.id;  
                  admin
                      .firestore()
                      .collection('timeline')
                      .doc(followerID)
                      .collection('Posts')
                      .doc(postID)
                      .delete();
              })
})

exports.onDeletePollPosts = functions.firestore.document("/PollPosts/{ownerID}/UserPollPosts/{postID}")
        .onDelete(async (snapshot,context)=>{
              const ownerID = context.params.ownerID; 
              const postID = context.params.postID; 

              const userFollowersRef = admin.firestore()
              .collection('followers')
              .doc(ownerID)
              .collection('UserFollowers');
      
              const followers =  await userFollowersRef.get(); 
      
              followers.forEach( doc=>{
                  const followerID = doc.id;  
                  admin
                      .firestore()
                      .collection('timeline')
                      .doc(followerID)
                      .collection('Posts')
                      .doc(postID)
                      .delete();
              })
})

//Can create onDelete functions of WatchAlongs/RecommendationPost/PollPost to ensure that when these are deleted by the user, the change is reflected on everyone's timeline