import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/entities/NavigateRecommendationPollParams.dart';
import 'package:socialentertainmentclub/helpers/font_size.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/timeline/CreatePollPostPage/PollOptionsListMovieTile.dart';
import 'package:socialentertainmentclub/presentation/blocs/create_poll_post/create_poll_post_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/recommendations_poll_movie_list/recommendations_poll_list_bloc.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/CustomTextField.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/Header.dart';

class CreatePollPostPage extends StatefulWidget {
  @override
  _CreatePollPostPageState createState() =>
      _CreatePollPostPageState();
}

class _CreatePollPostPageState extends State<CreatePollPostPage> {
  TextEditingController titleController =
      TextEditingController(); //Controller for post title field

  final formKey = GlobalKey<FormState>();

  CreatePollPostBloc createRecommendationsPollBloc;
  RecommendationsPollListBloc recommendationsPollListBloc;

  @override
  void initState() {
    super.initState();
    createRecommendationsPollBloc = getItInstance<CreatePollPostBloc>();
    recommendationsPollListBloc = getItInstance<RecommendationsPollListBloc>();
    createRecommendationsPollBloc.add(LoadCreatePollPostPage());

  }

  @override
  void dispose() {
    super.dispose();
    createRecommendationsPollBloc?.close();
    recommendationsPollListBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<CreatePollPostBloc>(
              create: (context) => createRecommendationsPollBloc,
            ),
            BlocProvider<RecommendationsPollListBloc>(
              create: (context) => recommendationsPollListBloc,
            ),
          ],
          child: SingleChildScrollView(
            child: BlocConsumer<CreatePollPostBloc,
                PollPostState>(
              listener: (context,state){
                if(state is CreatePollPostSubmitted){
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is CreatePollPostLoaded) {
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Header(heading: "Create a poll"),
                              SizedBox(height: Sizes.dimen_12.h,),
                              CustomTextField(
                                maxLength: 55,
                                minLength: 4,
                                controller: titleController,
                                hintText: "Title",
                              ), //Post-title field
                              SizedBox(height: Sizes.dimen_12.h),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric( vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Add Poll Options',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    BlocBuilder<RecommendationsPollListBloc, RecommendationsPollListState>(
                                      builder: (context, state) {
                                        if (state is RecommendationsPollListLoaded|| state is RecommendationsPollListInitial) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RadiantGradientMask(
                                                child: IconButton(
                                                  icon: Icon(Icons.add,color: Colors.white,),
                                                  onPressed: () =>
                                                      {
                                                        Navigator.of(context).pushNamed(RouteList.addRecommendationPage,
                                                            arguments: NavigateRecommendationsPollParams(
                                                              blocName: 'CreatePollPost',
                                                              recommendationsPollListBloc:  recommendationsPollListBloc
                                                            ),
                                                        )
                                                      },
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (state is RecommendationsPollListLoading) {
                                          return Center(
                                            child: RadiantGradientMask(
                                                child: CircularProgressIndicator()),
                                          );
                                        }
                                        return Center(
                                          child: Text(
                                            'Undefined state in RecommendationsPollListBloc $state',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                            ],
                          ),
                        ),//Add Movies To Poll List Button + Dividers Button
                        BlocBuilder<RecommendationsPollListBloc, RecommendationsPollListState>(
                          builder: (context, state) {
                            if (state is RecommendationsPollListLoaded) {
                              if(state.selectedMovies.length!=0){
                                return ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.selectedMovies.length,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context,index){
                                    return RecommendationListMovieTile(recommendationsPollListBloc: recommendationsPollListBloc,
                                        movie: state.selectedMovies[index]);
                                    },
                                );
                              }
                              return SizedBox.shrink();
                            } else if(state is RecommendationsPollListInitial){
                              return SizedBox.shrink();
                            }
                            else if (state is RecommendationsPollListLoading){
                              return SizedBox.shrink();
                            }
                            return Center(
                              child: Text(
                                'Undefined state in RecommendationsPollListBloc $state',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),//List view of selected movies
                      Padding(
                        padding: EdgeInsets.only(top:12.0),
                        child: GestureDetector(
                            onTap: (){
                              if(formKey.currentState.validate())
                              {BlocProvider.of<CreatePollPostBloc>(context)
                                .add(CreatePollPostSubmitEvent(
                              movies: recommendationsPollListBloc.selectedMovies,
                              context: context,
                              title: titleController.text,
                            ));}
                              },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                   Radius.circular(6),
                                   )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: ScreenUtil.screenWidth/2,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color:  ThemeColors.primaryColor,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Post',
                                          style: GoogleFonts.poppins(
                                            color:  ThemeColors.whiteTextColor,
                                            fontSize: FontSize.medium,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      ],
                    ),
                  );
                } else if (state is CreatePollPostLoading) {
                  return Center(
                    child: RadiantGradientMask(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Center(
                    child: Text(
                        'Undefined state inside CreateRecommendationsPollPage'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
