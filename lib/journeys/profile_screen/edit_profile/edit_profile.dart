
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:socialentertainmentclub/common/constants/route_constants.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/di/get_it.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/presentation/blocs/authentication_bloc/authentication_bloc.dart';

import 'package:socialentertainmentclub/presentation/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/CustomTextField.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/GenreTagField.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/Header.dart';
import 'package:socialentertainmentclub/presentation/views/SignUpView/widgets/loginButton.dart';
import 'package:socialentertainmentclub/presentation/widgets/app_error_widget.dart';




class EditProfile extends StatefulWidget {

  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  EditProfileBloc _editProfileBloc;
  TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  void initState() {
    _editProfileBloc = getItInstance<EditProfileBloc>();
    _editProfileBloc.add(LoadEditPageEvent(username: FirestoreConstants.currentUsername));
    usernameController.text=FirestoreConstants.currentUsername;
    super.initState();
  }

  @override
  void dispose() {
    _editProfileBloc?.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.vulcan,
        appBar: AppBar(
          backgroundColor: ThemeColors.vulcan,
        ),
        body: BlocProvider.value(
            value: _editProfileBloc,
            child: BlocConsumer<EditProfileBloc, EditProfileState>(
              listener: (context,state){
                if(state is EditProfileSuccess){
                  Navigator.pushNamedAndRemoveUntil(context, RouteList.initial, (route) => false);
                  context.read<AuthenticationBloc>().add(UserDetailsUpdateEvent(state.username, state.selectedGenres));
                }
              },
              builder: (context,state){
                if(state is EditProfilePageLoaded){
                  return Padding(
                        padding: const EdgeInsets.all(30),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Header(heading: "Edit Profile"),
                              SizedBox(height: 70),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      minLength: 4,
                                        maxLength: 12,
                                      controller: usernameController,
                                      hintText: "Pick a Username",
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              GenreTagField(genreMap:state.genres, tagStateKey: _tagStateKey,),
                              SizedBox(height: 16),
                              MainButton(
                                text: 'Save',
                                onTap: () {
                                  BlocProvider.of<EditProfileBloc>(context).add(EditButtonPress(mapGenresWithID: state.genres,
                                      username: usernameController.text, tagStateKey: _tagStateKey, context:context));
                                  },
                              ),
                            ],
                          ),
                        ),
                      );

                }
                else if(state is  EditProfileError){
                  return AppErrorWidget(onPressed: ()=> BlocProvider.of<EditProfileBloc>(context).add(
                      LoadEditPageEvent(username: FirestoreConstants.currentUsername),)
                    ,errorType: state.errorType,);
                }
                else if(state is EditProfilePageLoading||state is EditProfileInitial){
                  return Center(
                    child: RadiantGradientMask(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                print(state);

                return Center(child: Text("UndefinedState in EditPage",style:TextStyle(color: Colors.white)));
                },

            ),
          ),
      ),

    );
  }
}