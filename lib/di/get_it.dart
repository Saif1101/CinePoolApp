import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:socialentertainmentclub/data/core/api_client.dart';
import 'package:socialentertainmentclub/data/repositories/activity_feed_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/auth_repository.dart';
import 'package:socialentertainmentclub/data/repositories/post_from_feed_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/posts_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/recommendations_poll_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/user_and_authentication_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/genre_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/user_actions_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/watch_along_repository_impl.dart';
import 'package:socialentertainmentclub/data_sources/activity_feed_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/movie_preferences_remote_dataSource.dart';

import 'package:socialentertainmentclub/data_sources/movie_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/genres_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/post_from_feed_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/posts_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/recommendationsPolls_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/user_actions_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/user_and_authentication_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/watch_along_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/activity_feed_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/genre_repository.dart';

import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/post_from_feed.dart';
import 'package:socialentertainmentclub/domain/repositories/posts_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/AddRecommendationActivity.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/AddVoteActivity.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/DeleteActivityFromFeed.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/NewFollowerActivity.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/OptedIntoWatchAlongActivity.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/get_FeedItems.dart';

import 'package:socialentertainmentclub/domain/usecases/CreatePosts/CreateAskForRecommendations.dart';
import 'package:socialentertainmentclub/domain/usecases/CreatePosts/CreatePollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/PollPosts/delete_PollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/PollPosts/get_myPollPosts.dart';
import 'package:socialentertainmentclub/domain/usecases/PostActions/CastPollVote.dart';
import 'package:socialentertainmentclub/domain/usecases/PostActions/UpdateRecommendationsTrackMap.dart';
import 'package:socialentertainmentclub/domain/usecases/RecommendationPosts/delete_RecommendationPost.dart';
import 'package:socialentertainmentclub/domain/usecases/RecommendationPosts/get_myRecommendationPosts.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/add_MovieToFavorites.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/check_favorite.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_CastCrew.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_FavoriteMovies.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MapOfGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MovieDetail.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_MoviesByGenre.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_SearchedMovies.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_TrendingWeeklyMovies.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/remove_FavoriteMovie.dart';

import 'package:socialentertainmentclub/domain/usecases/posts/get_Posts.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_pollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_recommendationPost.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_watchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_FollowersAndFollowing.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_NewUserSignUp.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/check_IfFollowing.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/check_IfUserAlreadySigned.dart';

import 'package:socialentertainmentclub/domain/usecases/userandauth/get_CurrentFirebaseAccount.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_Followers.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_Following.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_RecentUsers.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_SearchedUsers.dart';

import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/remove_Follower.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/set_UsernameAndGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/signOut.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/sign_InWithGoogle.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_IfParticipant.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/create_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/delete_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/get_MyWatchAlongs.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/get_WatchAlongParticipants.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optInto_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optOutOf_WatchAlong.dart';
import 'package:socialentertainmentclub/presentation/blocs/activity_feed/activity_feed_bloc.dart';

import 'package:socialentertainmentclub/presentation/blocs/ask_for_recommendations_post/ask_for_recommendations_post_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/ask_for_recommendations_post_list/ask_for_recommendations_post_list_bloc.dart';

import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/cast/cast_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/create_ask_for_recommendations_post/create_ask_for_recommendations_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/create_poll_post/create_poll_post_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/my_poll_posts/mypollposts_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/my_recommendation_posts/myrecommendationposts_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/my_watch_alongs/my_watch_alongs_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/poll_post/poll_post_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/post_from_feed/post_from_feed_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/recommendations_poll_movie_list/recommendations_poll_list_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_page/search_page_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/favorite_movies/favorite_movies_bloc.dart';

import 'package:socialentertainmentclub/presentation/blocs/generic_movie_slider/generic_movie_slider_bloc.dart';

import 'package:socialentertainmentclub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:socialentertainmentclub/data/repositories/movie_repository_impl.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialentertainmentclub/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/profile_banner/profile_banner_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_users/search_users_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/timeline/timeline_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_form/watch_along_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_participation/watch_along_participation_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/watch_along_post/watch_along_post_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  //For core/api client
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  //Provider implementations
  getItInstance.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getItInstance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getItInstance.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);


  //For data source implementations
  getItInstance.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<GenresRemoteDataSource>(
      () => GenresRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MoviePreferencesRemoteDataSource>(() =>
      MoviePreferencesRemoteDataSourceImpl()); //no dependency needed therefore no getItInstances passed
  getItInstance.registerLazySingleton<UserActionsRemoteDataSource>(
      () => UserActionsRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<UserAndAuthenticationDataSource>(
      () => UserAndAuthenticationDataSourceImpl(

          ));
  getItInstance.registerLazySingleton<WatchAlongDataSource>(
      () => WatchAlongDataSourceImpl());
  getItInstance.registerLazySingleton<RecommendationsPollsDataSource>(
      () => RecommendationsPollsDataSourceImpl());
  getItInstance.registerLazySingleton<ActivityFeedDataSource>(
      () => ActivityFeedDataSourceImpl());
  getItInstance.registerLazySingleton<PostFromFeedDataSource>(
      () => PostFromFeedDataSourceImpl());

  //Usecase implementations
  getItInstance.registerLazySingleton<GetTrendingWeekly>(
      () => GetTrendingWeekly(getItInstance()));
  getItInstance.registerLazySingleton<GetMoviesByGenre>(
      () => GetMoviesByGenre(getItInstance()));
  getItInstance.registerLazySingleton<GetMapOfGenres>(
      () => GetMapOfGenres(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchedMovies>(
      () => GetSearchedMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchedUsers>(
      () => GetSearchedUsers(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPosts>(() => GetPosts(getItInstance()));

  //Usecases - Follow/Unfollow
  getItInstance.registerLazySingleton<AddFollowersAndFollowing>(
      () => AddFollowersAndFollowing(getItInstance()));
  getItInstance.registerLazySingleton<RemoveFollower>(
      () => RemoveFollower(getItInstance()));
  getItInstance
      .registerLazySingleton<GetFollowers>(() => GetFollowers(getItInstance()));
  getItInstance
      .registerLazySingleton<GetFollowing>(() => GetFollowing(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFollowing>(
      () => CheckIfFollowing(getItInstance()));

  //Usecase - CRUD operations for favorited movies
  getItInstance.registerLazySingleton<CheckIfFavorite>(
      () => CheckIfFavorite(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<AddMovieToFavorites>(
      () => AddMovieToFavorites(getItInstance()));
  getItInstance.registerLazySingleton<RemoveFavoriteMovie>(
      () => RemoveFavoriteMovie(getItInstance()));

  //Usecases - User Data And Authentication
  getItInstance.registerLazySingleton<NewUserSignUp>(
      () => NewUserSignUp(getItInstance()));
  
   getItInstance.registerLazySingleton<CheckIfUserAlreadySignedIn>(
      () => CheckIfUserAlreadySignedIn(getItInstance()));


  getItInstance.registerLazySingleton<SetUsernameAndGenres>(
      () => SetUsernameAndGenres(getItInstance()));
  getItInstance.registerLazySingleton<SignOut>(
      () => SignOut(getItInstance()));
  getItInstance.registerLazySingleton<GetUserFromID>(
      () => GetUserFromID(getItInstance()));

  getItInstance.registerLazySingleton<GetRecentUsers>(() => GetRecentUsers(getItInstance()));

  

  //Usecases - Watch Alongs
  getItInstance.registerLazySingleton<CheckWatchAlong>(
      () => CheckWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<CreateWatchAlong>(
      () => CreateWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<OptIntoWatchAlong>(
      () => OptIntoWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<OptOutOfWatchAlong>(
      () => OptOutOfWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfParticipant>(
      () => CheckIfParticipant(getItInstance()));
  getItInstance.registerLazySingleton<GetMyWatchAlongs>(
      () => GetMyWatchAlongs(getItInstance()));
  getItInstance.registerLazySingleton<DeleteWatchAlong>(
      () => DeleteWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<GetWatchAlongParticipants>(
      () => GetWatchAlongParticipants(getItInstance()));

  //Recommendation/Polls Usecases
  getItInstance.registerLazySingleton<CreatePollPost>(
      () => CreatePollPost(getItInstance()));
  getItInstance.registerLazySingleton<CreateAskForRecommendationsPost>(
      () => CreateAskForRecommendationsPost(getItInstance()));
  getItInstance.registerLazySingleton<UpdateRecommendationsTrackMap>(
      () => UpdateRecommendationsTrackMap(getItInstance()));
  getItInstance
      .registerLazySingleton<CastPollVote>(() => CastPollVote(getItInstance()));
  getItInstance.registerLazySingleton<GetMyRecommendationPosts>(
      () => GetMyRecommendationPosts(getItInstance()));
  getItInstance.registerLazySingleton<GetMyPollPosts>(
      () => GetMyPollPosts(getItInstance()));
  getItInstance.registerLazySingleton<DeletePollPost>(
      () => DeletePollPost(getItInstance()));
  getItInstance.registerLazySingleton<DeleteRecommendationPost>(
      () => DeleteRecommendationPost(getItInstance()));

  getItInstance.registerLazySingleton<SignInWithGoogle>(
      () => SignInWithGoogle(getItInstance()));
  getItInstance.registerLazySingleton<GetCurrentFirebaseUser>(
      () => GetCurrentFirebaseUser(getItInstance()));
  

  //Activity Feed
  getItInstance.registerLazySingleton<AddVoteActivity>(
      () => AddVoteActivity(getItInstance()));
  getItInstance.registerLazySingleton<AddRecommendationActivity>(
      () => AddRecommendationActivity(getItInstance()));
  getItInstance
      .registerLazySingleton<GetFeedItems>(() => GetFeedItems(getItInstance()));
  getItInstance.registerLazySingleton<AddNewFollowerActivity>(
      () => AddNewFollowerActivity(getItInstance()));
  getItInstance.registerLazySingleton<OptedIntoWatchAlongActivity>(
      () => OptedIntoWatchAlongActivity(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPollPost>(() => GetPollPost(getItInstance()));
  getItInstance.registerLazySingleton<GetRecommendationPost>(
      () => GetRecommendationPost(getItInstance()));
  getItInstance.registerLazySingleton<GetWatchAlong>(
      () => GetWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<DeleteActivityFromFeed>(
      () => DeleteActivityFromFeed(getItInstance()));

  //Repository implementations
  getItInstance.registerLazySingleton<AuthRepository>(
      () => AuthRepository(
        firestore: getItInstance(),
        firebaseAuth:getItInstance(), 
        googleSignIn:getItInstance(), 
      )
    );

  getItInstance.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(postsRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<PostFromFeedRepository>(
      () => PostFromFeedRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<GenreRepository>(
      () => GenreRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(() =>
      MovieRepositoryImpl(
          moviePreferencesRemoteDataSource: getItInstance(),
          remoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<UserAndAuthenticationRepository>(() =>
      UserAndAuthenticationRepositoryImpl(
          userAndAuthenticationDataSource: getItInstance()
          ));
  getItInstance.registerLazySingleton<ActivityFeedRepository>(
      () => ActivityFeedRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<WatchAlongRepository>(
      () => WatchAlongRepositoryImpl(watchAlongDataSource: getItInstance()));
  getItInstance.registerLazySingleton<UserActionsRepository>(() =>
      UserActionsRepositoryImpl(userActionsRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<RecommendationsPollRepository>(() =>
      RecommendationsPollRepositoryImpl(
          recommendationsPollsDataSource: getItInstance()));

  //Instantiating BloCs
  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => SearchMoviesBloc(
        getSearchedMovies: getItInstance(),
      ));

  getItInstance.registerFactory(() => SearchUsersBloc(
        getSearchedUsers: getItInstance(),
      ));

  getItInstance.registerFactory(() => SearchPageBloc());

  getItInstance.registerFactory(() => MovieCarouselBloc(
        getTrendingWeekly: getItInstance(),
        movieBackdropBloc: getItInstance(),
      ));

  getItInstance.registerFactory(() => AuthenticationBloc(
       
        checkIfUserAlreadySignedIn: getItInstance(),
        getMapOfGenres: getItInstance(),
        newUserSignUp: getItInstance(),
        setUsernameAndGenres: getItInstance(),
        unauthenticate: getItInstance(),
        getCurrentFirebaseUser: getItInstance(), 
        getUserFromID: getItInstance(),
        signInWithGoogle:getItInstance(),
      ));

  getItInstance.registerFactory(() => GenericMovieSliderBloc(
        getMoviesByGenre: getItInstance(),
      ));

  getItInstance.registerFactory(() => CastBloc(
        getCast: getItInstance(),
      ));

  getItInstance.registerFactory(() => FavoriteMoviesBloc(
        getFavoritemovies: getItInstance(),
        addMovieToFavorites: getItInstance(),
        removeFavoriteMovie: getItInstance(),
        checkIfFavorite: getItInstance(),
      ));

  getItInstance.registerFactory(() => WatchAlongFormBloc(
        checkWatchAlong: getItInstance(),
        createWatchAlong: getItInstance(),
        deleteWatchAlong: getItInstance(),
      ));

  getItInstance.registerFactory(() => MovieDetailBloc(
        watchAlongBloc: getItInstance(),
        favoriteMoviesBloc: getItInstance(),
        castBloc: getItInstance(),
        getMovieDetail: getItInstance(),
      ));

  getItInstance.registerFactory(() => ProfileBannerBloc(
        addFollowersAndFollowing: getItInstance(),
        removeFollower: getItInstance(),
        getFollowing: getItInstance(),
        getFollowers: getItInstance(),
        checkIfFollowing: getItInstance(),
        addNewFollowerActivity: getItInstance(),
      ));

  getItInstance.registerFactory(() => EditProfileBloc(
      getMapOfGenres: getItInstance(), setUsernameAndGenres: getItInstance()));

  getItInstance.registerFactory(() => WatchAlongParticipationBloc(
        getUserFromID: getItInstance(),
        getWatchAlongParticipants: getItInstance(),
        optIntoWatchAlong: getItInstance(),
        optOutOfWatchAlong: getItInstance(),
        checkIfParticipant: getItInstance(),
        optedIntoWatchAlongActivity: getItInstance(),
      ));

  getItInstance.registerFactory(() => CreateAskForRecommendationsBloc(
      getMapOfGenres: getItInstance(),
      createAskForRecommendationsPost: getItInstance()));

  getItInstance.registerFactory(() => WatchAlongPostBloc(
        getWatchAlongParticipants: getItInstance(),
        deleteWatchAlong: getItInstance(),
        getUserFromID: getItInstance(),
        getMovieDetail: getItInstance(),
        watchAlongParticipationBloc: getItInstance(),
      ));

  getItInstance.registerFactory(() => TimelineBloc(
    getRecentUsers: getItInstance(),
    getPosts: getItInstance()));

  getItInstance.registerFactory(() => CreatePollPostBloc(
      createPollPost: getItInstance(), getMapOfGenres: getItInstance()));

  getItInstance.registerFactory(() => RecommendationsPollListBloc());

  getItInstance.registerFactory(() => AskForRecommendationsPostListBloc(
        updateRecommendationsTrackMap: getItInstance(),
        getUserFromID: getItInstance(),
        getMovieDetail: getItInstance(),
        addRecommendationActivity: getItInstance(),
      ));

  getItInstance.registerFactory(() => PollPostBloc(
        deletePollPost: getItInstance(),
        getMovieDetail: getItInstance(),
        getUserFromID: getItInstance(),
        castPollVote: getItInstance(),
        addVoteActivity: getItInstance(),
      ));

  getItInstance.registerFactory(() => AskForRecommendationsPostBloc(
      deleteRecommendationPost: getItInstance(),
      getUserFromID: getItInstance()));

  getItInstance.registerFactory(
      () => MyWatchAlongsBloc(getMyWatchAlongs: getItInstance()));

  getItInstance.registerFactory(() =>
      MyRecommendationPostsBloc(getMyRecommendationPosts: getItInstance()));

  getItInstance
      .registerFactory(() => MyPollPostsBloc(getMyPollPosts: getItInstance()));

  getItInstance
      .registerFactory(() => ActivityFeedBloc(getFeedItems: getItInstance()));

  getItInstance.registerFactory(() => PostFromFeedBloc(
      deleteActivityFromFeed: getItInstance(),
      getPollPost: getItInstance(),
      getWatchAlong: getItInstance(),
      getRecommendationPost: getItInstance(),
       getUserFromID: getItInstance()));
}
