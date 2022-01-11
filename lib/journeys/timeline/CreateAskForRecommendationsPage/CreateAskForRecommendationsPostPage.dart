import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/presentation/blocs/create_ask_for_recommendations_post/create_ask_for_recommendations_bloc.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/CustomTextField.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/GenreTagField.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/Header.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/loginButton.dart';
import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';
//Ask for recommendationsPost has the same structure as the edit profile page.

class CreateAskForRecommendationsPostPage extends StatefulWidget {
  @override
  _CreateAskForRecommendationsPostPageState createState() => _CreateAskForRecommendationsPostPageState();
}

class _CreateAskForRecommendationsPostPageState extends State<CreateAskForRecommendationsPostPage> {

  CreateAskForRecommendationsBloc createAskForRecommendationsBloc;

  TextEditingController titleController =
  TextEditingController(); //Controller for post title field
  TextEditingController descController =
  TextEditingController(); //Controller for post description field
  final _formKey = GlobalKey<FormState>(); //form key for validation
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>(); //tags

  @override
  void initState() {
    super.initState();
    createAskForRecommendationsBloc = getItInstance<CreateAskForRecommendationsBloc>();
    createAskForRecommendationsBloc.add(LoadAskForRecommendationsEvent());
  }

  @override
  void dispose() {

    super.dispose();
    createAskForRecommendationsBloc?.close();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.vulcan,
        body: BlocProvider.value(
          value: createAskForRecommendationsBloc,
          child: BlocConsumer<CreateAskForRecommendationsBloc, CreateAskForRecommendationsState>(
            listener: (context,state){
              if(state is CreateAskForRecommendationsPostSuccess){
                Navigator.pop(context);
              }
            },
            builder: (context,state){
              if(state is CreateAskForRecommendationsPostLoaded){
                return Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(heading: "Ask For Recommendations"),
                        SizedBox(height: 70),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                minLength: 4,
                                maxLength: 12,
                                controller: titleController,
                                hintText: "Title",
                              ),
                              CustomTextField(
                                minLength: 4,
                                maxLength: 56,
                                controller: descController,
                                hintText: "Description",
                              ),
                              SizedBox(height: 16),
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
                                child: Text(
                                    'Preferred Genre(s)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),//Add Movies To Poll List Button + Dividers Button

                        GenreTagField(genreMap:state.genres, tagStateKey: _tagStateKey,),
                        SizedBox(height: 16),
                        MainButton(
                          text: 'Post',
                          onTap: () {
                            BlocProvider.of<CreateAskForRecommendationsBloc>(context).add(CreateAskForRecommendationsButtonPress
                              (mapGenresWithID: state.genres,
                                title: titleController.text,
                                description: descController.text,
                                tagStateKey: _tagStateKey,
                                context:context));
                          },
                        ),
                      ],
                    ),
                  ),
                );

              }
              else if(state is  CreateAskForRecommendationsPostError){
                return AppErrorWidget(onPressed: ()=> BlocProvider.of<CreateAskForRecommendationsBloc>(context).add(
                  LoadAskForRecommendationsEvent(),)
                  ,errorType: state.errorType,);
              }
              else if(state is CreateAskForRecommendationsPostLoading || state is CreateAskForRecommendationsPostInitial){
                return Center(
                  child: RadiantGradientMask(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(child: Text("UndefinedState in CreateAskForRecommendationsPost",style:TextStyle(color: Colors.white)));
            },

          ),
        ),
      ),

    );
  }
}
