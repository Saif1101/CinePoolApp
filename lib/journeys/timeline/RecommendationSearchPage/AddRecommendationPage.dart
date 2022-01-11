import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/entities/NavigateRecommendationPollParams.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/search/SearchTextField.dart';
import 'package:socialentertainmentclub/journeys/timeline/RecommendationSearchPage/MovieSearchRecommendationCard.dart';
import 'package:socialentertainmentclub/presentation/blocs/ask_for_recommendations_post_list/ask_for_recommendations_post_list_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/recommendations_poll_movie_list/recommendations_poll_list_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_movies/search_movies_bloc.dart';

class AddRecommendationPage extends StatefulWidget {
  final NavigateRecommendationsPollParams navigateRecommendationsPollParams;



  const AddRecommendationPage({Key key,this.navigateRecommendationsPollParams}) : super(key: key);

  @override
  _AddRecommendationPageState createState() => _AddRecommendationPageState();
}

class _AddRecommendationPageState extends State<AddRecommendationPage> {



  SearchMoviesBloc recommendationSearchBloc;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    recommendationSearchBloc = getItInstance<SearchMoviesBloc>();
  }


  @override
  void dispose() {
    super.dispose();
    recommendationSearchBloc?.close();

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMoviesBloc>(
          create: (context) => recommendationSearchBloc,
        ),
        widget.navigateRecommendationsPollParams.blocName=='CreatePollPost'?
        BlocProvider.value(
            value: widget
                .navigateRecommendationsPollParams
                .recommendationsPollListBloc
        ):
        BlocProvider.value(
            value: widget
                .navigateRecommendationsPollParams
                .askForRecommendationsPostListBloc
        )

      ],
      child: Scaffold(
        backgroundColor: ThemeColors.vulcan,
        appBar: AppBar(
          backgroundColor: ThemeColors.vulcan.withOpacity(0.3),
          title: SearchTextField(
              onSubmit: (query){
                recommendationSearchBloc.add(SearchMoviesTermChangedEvent(searchTerm: query));
                }, searchController: searchController)
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<SearchMoviesBloc,SearchMoviesState>(
                cubit: recommendationSearchBloc,
                builder: (context,state){
                  if(state is SearchMoviesLoaded) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_48.w),
                          child: Text(
                            '...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.dimen_6.h,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: movies.length,
                        itemBuilder: (context, index) =>
                            widget.navigateRecommendationsPollParams.blocName=='CreatePollPost'
                                ? InkWell(
                              onLongPress: (){
                                if(widget.navigateRecommendationsPollParams.blocName=='CreatePollPost'){
                                  widget
                                      .navigateRecommendationsPollParams
                                      .recommendationsPollListBloc
                                      .add(AddMovieRecommendationEvent(selectedMovie: movies[index]));
                                }
                                Navigator.pop(context);
                                },
                              child: MovieSearchRecommendationCard(
                                movie: movies[index],
                          ),
                            )
                                : BlocBuilder<AskForRecommendationsPostListBloc, AskForRecommendationsPostListState>(
                                builder: (context,state){
                                  if(state is AskForRecommendationsPostListLoaded){
                                    return InkWell(
                                      onLongPress: (){
                                              BlocProvider.of<AskForRecommendationsPostListBloc>(context).add(
                                                  AddMovieToRecommendationsPostListEvent(
                                                    movies: state.movies,
                                                        users:state.users,
                                              ownerID: state.ownerID,
                                              postID: state.postID,
                                              recommendationsTrackMap: state.recommendationsTrackMap,
                                              movieID: movies[index].id, movieUserMap: state.movieUserMap)
                                          );
                                        Navigator.pop(context);
                                      },
                                      child: MovieSearchRecommendationCard(
                                        movie: movies[index],
                                      ),
                                    );
                                  };
                                  return SizedBox.shrink();
                          }
                          ),
                        scrollDirection: Axis.vertical,
                      ),
                    );
                  }
                  else if (state is SearchMoviesError) {
                    return Center(child: Text("Error Occured While Searching"),);
                  }
                  else if(state is SearchMoviesResultsCleared) {
                    return SizedBox.shrink();
                  }
                  return SizedBox.shrink();
                }
            ),
          ],
        ),
      ),
      );
  }
}
