import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/search/CustomRadioButton.dart';
import 'package:socialentertainmentclub/journeys/search/SearchTextField.dart';
import 'package:socialentertainmentclub/journeys/search/search_movie_card.dart';
import 'package:socialentertainmentclub/journeys/search/search_user_card.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_page/search_page_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/search_users/search_users_bloc.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  SearchPageBloc searchPageBloc;
  SearchMoviesBloc searchMoviesBloc;
  SearchUsersBloc searchUsersBloc;

  @override
  void initState() {

    searchPageBloc = getItInstance<SearchPageBloc>();
    searchMoviesBloc = getItInstance<SearchMoviesBloc>();
    searchUsersBloc = getItInstance<SearchUsersBloc>();

    super.initState();
  }

  @override
  void dispose() {
    searchPageBloc?.close();
    searchMoviesBloc?.close();
    searchUsersBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchPageBloc>(create: (context) => searchPageBloc),
        BlocProvider<SearchMoviesBloc>(create: (context) => searchMoviesBloc),
        BlocProvider<SearchUsersBloc>(create: (context) => searchUsersBloc),
      ],
      child: Scaffold(
        backgroundColor: ThemeColors.vulcan,
        appBar: AppBar(
          backgroundColor: ThemeColors.vulcan.withOpacity(0.3),
          title: Container(
            child: BlocBuilder<SearchPageBloc, SearchPageState>(
              builder: (context, state) {
                print(state);
                if(state is UserSearch){
                  return SearchTextField(onSubmit: (query){BlocProvider.of<SearchUsersBloc>(context).add
                    (SearchUsersTermChangedEvent(searchTerm: query));},
                      searchController: searchController);
                } else{
                  return SearchTextField(onSubmit: (query){BlocProvider.of<SearchMoviesBloc>(context).add(
                    SearchMoviesTermChangedEvent(searchTerm: query),);},
                      searchController: searchController);
                }
              },
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRadio(onTapUser: (){searchPageBloc.add(UserSearchSelectEvent());
            searchMoviesBloc.add(ClearMovieSearchResultsEvent());},
                onTapMovie: (){searchPageBloc.add(MovieSearchSelectEvent());
            searchUsersBloc.add(ClearUserSearchResultsEvent());}),
            BlocBuilder<SearchMoviesBloc,SearchMoviesState>(
              cubit: searchMoviesBloc,
                builder: (context,state){
                  if(BlocProvider.of<SearchPageBloc>(context).state is MovieSearch && state is SearchMoviesLoaded){
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
                        itemBuilder: (context, index) => SearchMovieCard(
                          movie: movies[index],
                        ),
                        scrollDirection: Axis.vertical,
                      ),
                    );
                  }
                  else if (state is SearchMoviesError) {
                    return Center(child: Text("Error Occured While Searching"),);
                  }
                  else if(state is SearchMoviesResultsCleared
                  ){
                    return SizedBox.shrink();
                  }
                  return SizedBox.shrink();
                }
            ),
            BlocBuilder<SearchUsersBloc,SearchUsersState>(
                builder: (context,state){
                  if(BlocProvider.of<SearchPageBloc>(context).state is UserSearch && state is SearchUsersLoaded){
                    final users = state.users;
                    if (users.isEmpty) {
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
                        itemBuilder: (context, index) => SearchUserCard(
                          user: users[index],
                        ),
                        itemCount: users.length,
                        scrollDirection: Axis.vertical,
                      ),
                    );
                  }
                  else if (state is SearchUsersError) {
                    return Center(child: Text("Error Occured While Searching"),);
                  }
                  else if(state is SearchUsersResultsCleared){
                    return SizedBox.shrink();
                  }
                  return SizedBox.shrink();
                }
            )
          ],
        ),
      ),
    );
  }
}


