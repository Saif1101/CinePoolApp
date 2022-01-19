import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:socialentertainmentclub/data/core/api_client.dart';
import 'package:socialentertainmentclub/data/repositories/posts_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/recommendations_poll_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/user_and_authentication_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/genre_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/user_actions_repository_impl.dart';
import 'package:socialentertainmentclub/data/repositories/watch_along_repository_impl.dart';
import 'package:socialentertainmentclub/data_sources/movie_preferences_remote_dataSource.dart';

import 'package:socialentertainmentclub/data_sources/movie_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/genres_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/posts_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/recommendationsPolls_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/user_actions_remote_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/user_and_authentication_dataSource.dart';
import 'package:socialentertainmentclub/data_sources/watch_along_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/genre_repository.dart';

import 'package:socialentertainmentclub/domain/repositories/movie_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/posts_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/user_actions_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/user_and_authentication_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/watch_along_repository.dart';
import 'package:socialentertainmentclub/domain/repositories/recommendations_poll_repository.dart';


import 'package:socialentertainmentclub/domain/usecases/CreatePosts/CreateAskForRecommendations.dart';
import 'package:socialentertainmentclub/domain/usecases/CreatePosts/CreatePollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/PollPosts/get_myPollPosts.dart';
import 'package:socialentertainmentclub/domain/usecases/PostActions/CastPollVote.dart';
import 'package:socialentertainmentclub/domain/usecases/PostActions/UpdateRecommendationsTrackMap.dart';
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
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_FollowersAndFollowing.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/add_NewUserSignUp.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/check_IfFollowing.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_AuthCredentialFromFirebaseUser.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_AuthenticationDetailFromGoogle.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_Followers.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_Following.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_SearchedUsers.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_User.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/remove_Follower.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/set_UsernameAndGenres.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/unauthenticate.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_IfParticipant.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/create_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/delete_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/get_MyWatchAlongs.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optInto_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optOutOf_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/remove_WatchAlong.dart';
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
import 'package:socialentertainmentclub/presentation/blocs/recommendations_poll_movie_list/recommendations_poll_list_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_page/search_page_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/firebase_authentication.dart';
import 'package:socialentertainmentclub/presentation/blocs/firestore/google_sign_in_provider.dart';
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
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  //Provider implementations
  getItInstance.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getItInstance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getItInstance.registerLazySingleton<GoogleSignInProvider>(() => GoogleSignInProvider(googleSignIn : getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationFirebaseProvider>(() => AuthenticationFirebaseProvider(firebaseAuth: getItInstance()));

  //For data source implementations
  getItInstance.registerLazySingleton<PostsRemoteDataSource>(() => PostsRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<GenresRemoteDataSource>(() => GenresRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MoviePreferencesRemoteDataSource>(() => MoviePreferencesRemoteDataSourceImpl()); //no dependency needed therefore no getItInstances passed
  getItInstance.registerLazySingleton<UserActionsRemoteDataSource>(() => UserActionsRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<UserAndAuthenticationDataSource>(() => UserAndAuthenticationDataSourceImpl(
    authenticationFirebaseProvider: getItInstance(),
    googleSignInProvider: getItInstance(),
  ));

  getItInstance.registerLazySingleton<WatchAlongDataSource>(() => WatchAlongDataSourceImpl());
  getItInstance.registerLazySingleton<RecommendationsPollsDataSource>(() => RecommendationsPollsDataSourceImpl());





  //Usecase implementations
  getItInstance.registerLazySingleton<GetTrendingWeekly>(() => GetTrendingWeekly(getItInstance()));
  getItInstance.registerLazySingleton<GetMoviesByGenre>(() => GetMoviesByGenre(getItInstance()));
  getItInstance.registerLazySingleton<GetMapOfGenres>(() => GetMapOfGenres(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchedMovies>(() => GetSearchedMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchedUsers>(() => GetSearchedUsers(getItInstance()));

  getItInstance.registerLazySingleton<GetPosts>(() => GetPosts(getItInstance()));


  //Usecases - Follow/Unfollow
  getItInstance.registerLazySingleton<AddFollowersAndFollowing>(() => AddFollowersAndFollowing(getItInstance()));
  getItInstance.registerLazySingleton<RemoveFollower>(() => RemoveFollower(getItInstance()));
  getItInstance.registerLazySingleton<GetFollowers>(() => GetFollowers(getItInstance()));
  getItInstance.registerLazySingleton<GetFollowing>(() => GetFollowing(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFollowing>(() => CheckIfFollowing(getItInstance()));

  //Usecase - CRUD operations for favorited movies
  getItInstance.registerLazySingleton<CheckIfFavorite>(() => CheckIfFavorite(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(() => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<AddMovieToFavorites>(() => AddMovieToFavorites(getItInstance()));
  getItInstance.registerLazySingleton<RemoveFavoriteMovie>(() => RemoveFavoriteMovie(getItInstance()));

  //Usecases - User Data And Authentication
  getItInstance.registerLazySingleton<GetAuthenticationDetailFromGoogle>(() =>GetAuthenticationDetailFromGoogle(getItInstance()));
  getItInstance.registerLazySingleton<GetAuthCredentialFromFirebaseUser>(() =>GetAuthCredentialFromFirebaseUser(getItInstance()));
  getItInstance.registerLazySingleton<NewUserSignUp>(() => NewUserSignUp(getItInstance()));
  getItInstance.registerLazySingleton<GetUserFromAuthDetail>(() => GetUserFromAuthDetail(getItInstance()));
  getItInstance.registerLazySingleton<SetUsernameAndGenres>(() => SetUsernameAndGenres(getItInstance()));
  getItInstance.registerLazySingleton<Unauthenticate>(() => Unauthenticate(getItInstance()));
  getItInstance.registerLazySingleton<GetUserFromID>(() => GetUserFromID(getItInstance()));

  //Usecases - Watch Alongs
  getItInstance.registerLazySingleton<CheckWatchAlong>(() => CheckWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<CreateWatchAlong>(() => CreateWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<OptIntoWatchAlong>(() => OptIntoWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<OptOutOfWatchAlong>(() => OptOutOfWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<RemoveWatchAlong>(() => RemoveWatchAlong(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfParticipant>(() =>CheckIfParticipant(getItInstance()));
  getItInstance.registerLazySingleton<GetMyWatchAlongs>(() => GetMyWatchAlongs(getItInstance()));
  getItInstance.registerLazySingleton<DeleteWatchAlong>(() =>DeleteWatchAlong(getItInstance()));

  //Recommendation/Polls Usecases
  getItInstance.registerLazySingleton<CreatePollPost>(() => CreatePollPost(getItInstance()));
  getItInstance.registerLazySingleton<CreateAskForRecommendationsPost>(() => CreateAskForRecommendationsPost(getItInstance()));
  getItInstance.registerLazySingleton<UpdateRecommendationsTrackMap>(()=>UpdateRecommendationsTrackMap(getItInstance()));
  getItInstance.registerLazySingleton<CastPollVote>(()=>CastPollVote(getItInstance()));
  getItInstance.registerLazySingleton<GetMyRecommendationPosts>(() =>GetMyRecommendationPosts(getItInstance()));
  getItInstance.registerLazySingleton<GetMyPollPosts>(() =>GetMyPollPosts(getItInstance()));


  //Repository implementations
  getItInstance.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(postsRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<GenreRepository>(() => GenreRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(moviePreferencesRemoteDataSource: getItInstance(),
      remoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<UserAndAuthenticationRepository>(() => UserAndAuthenticationRepositoryImpl(
    userAndAuthenticationDataSource: getItInstance(),
      authenticationFirebaseProvider: getItInstance(),
  googleSignInProvider: getItInstance()));
  getItInstance.registerLazySingleton<WatchAlongRepository>(() => WatchAlongRepositoryImpl(watchAlongDataSource: getItInstance()));
  getItInstance.registerLazySingleton<UserActionsRepository>(() => UserActionsRepositoryImpl(userActionsRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<RecommendationsPollRepository>(() => RecommendationsPollRepositoryImpl(recommendationsPollsDataSource: getItInstance()));



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
    authenticationFireBaseProvider: getItInstance(),
    getMapOfGenres: getItInstance(),
    newUserSignUp:  getItInstance(),
    setUsernameAndGenres: getItInstance(),
    unauthenticate:  getItInstance(),
    getAuthenticationDetailFromGoogle:  getItInstance(),
    getUserFromAuthDetail: getItInstance(),
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

  getItInstance.registerFactory(()=>WatchAlongFormBloc(checkWatchAlong: getItInstance(),
      createWatchAlong: getItInstance(),
      removeWatchAlong: getItInstance())
  );


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
  ));

  getItInstance.registerFactory(() => EditProfileBloc(
      getMapOfGenres:getItInstance() ,
      setUsernameAndGenres:getItInstance()
  )
  );

  getItInstance.registerFactory(() => WatchAlongParticipationBloc(
      optIntoWatchAlong: getItInstance(),
      optOutOfWatchAlong: getItInstance(),
      checkIfParticipant: getItInstance(),
  )
  );

  getItInstance.registerFactory(() => CreateAskForRecommendationsBloc(
      getMapOfGenres: getItInstance(),
      createAskForRecommendationsPost: getItInstance()
  )
  );

  getItInstance.registerFactory(() => WatchAlongPostBloc(
    deleteWatchAlong: getItInstance(),
      getUserFromID: getItInstance(),
      getMovieDetail: getItInstance(),
    watchAlongParticipationBloc: getItInstance(),
  )
  );

  getItInstance.registerFactory(() => TimelineBloc(
    getPosts: getItInstance()
  ));

  getItInstance.registerFactory(() => CreatePollPostBloc(
      createPollPost:getItInstance(),
      getMapOfGenres: getItInstance())
  );

  getItInstance.registerFactory(() => RecommendationsPollListBloc());

  getItInstance.registerFactory(() => AskForRecommendationsPostListBloc(
      updateRecommendationsTrackMap: getItInstance(),
      getUserFromID:getItInstance(),
      getMovieDetail: getItInstance())
  );

  getItInstance.registerFactory(() => PollPostBloc(
      getMovieDetail: getItInstance(),
      getUserFromID: getItInstance(),
      castPollVote: getItInstance(),
  )
  );

  getItInstance.registerFactory(() => AskForRecommendationsPostBloc
    (
      getUserFromID:getItInstance()
  ));

  getItInstance.registerFactory(() =>
      MyWatchAlongsBloc(
          getMyWatchAlongs: getItInstance()
      )
  );

  getItInstance.registerFactory(() => 
    MyRecommendationPostsBloc(
      getMyRecommendationPosts: getItInstance()
    )
  );

  getItInstance.registerFactory(() => 
    MyPollPostsBloc(
      getMyPollPosts: getItInstance()
    )
  );


}



