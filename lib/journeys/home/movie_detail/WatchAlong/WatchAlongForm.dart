import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/data/core/API_constants.dart';
import 'package:socialentertainmentclub/helpers/shader_mask.dart';

import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/extensions/string_extensions.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';

import 'package:socialentertainmentclub/presentation/blocs/watch_along_form/watch_along_bloc.dart';


class WatchAlongForm extends StatefulWidget {
  final String moviePosterPath;
  final String movieID;
  final String movieTitle;

  WatchAlongForm({Key key, @required this.moviePosterPath,
    @required this.movieID,
    @required this.movieTitle}) : super(key: key);

  @override
  _WatchAlongFormState createState() => _WatchAlongFormState();
}

class _WatchAlongFormState extends State<WatchAlongForm> {
  final TextEditingController dateTimeLabelController = new TextEditingController();
  final TextEditingController dateTimeController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController whereController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateTimeLabelController.text = 'Date/Time';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchAlongFormBloc, WatchAlongState>(
      builder: (context, state) {
        if(state is CreateWatchAlongState){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: ThemeColors.vulcan.withOpacity(0.9),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.white.withOpacity(0.45),
                                  Colors.white.withOpacity(0.7),
                                  Colors.white
                                ]
                            )
                        ),
                        child: widget.moviePosterPath!=null?CachedNetworkImage(
                          imageUrl: '${ApiConstants.BASE_IMAGE_URL}${widget.moviePosterPath}',
                          width: ScreenUtil.screenWidth/4,
                        ):Image.asset('assets/images/FreeVector-Sync-Slate.jpg',),
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('${widget.movieTitle}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: Sizes.dimen_8.h
                                ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(

                                onSaved: (value){
                                  titleController.text = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Empty';
                                  }
                                  else if(value.length>13){
                                    return 'The title should be less than 13 characters';
                                  }
                                  else if(value.length<2){
                                    return 'The title should be more than 2 characters';
                                  }
                                  return null;
                                },
                                autofocus: false,
                                style: new TextStyle(fontWeight: FontWeight.normal,
                                  color: Colors.white,),
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          6.0
                                      )
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                onSaved: (value){
                                  whereController.text = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Empty';
                                  }
                                  else if(value.length>13){
                                    return 'The title should be less than 13 characters';
                                  }
                                  else if(value.length<2){
                                    return 'The title should be more than 2 characters';
                                  }
                                  return null;
                                },
                                autofocus: false,
                                style: new TextStyle(fontWeight: FontWeight.normal,
                                  color: Colors.white,),
                                decoration: InputDecoration(
                                  hintText: 'Where?',
                                  hintStyle: TextStyle(color: Colors.white),

                                  contentPadding: new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            6.0
                                        )
                                    ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ThemeColors.primaryColor
                                    ),
                                    child: RaisedButton(
                                      color: ThemeColors.primaryColor,
                                        onPressed: () {
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime(2019, 6, 7),
                                              onChanged: (date) {
                                              }, onConfirm: (date) {
                                            dateTimeController.text = date.toString();
                                            dateTimeLabelController.text = date.toString().getDateTime();
                                              }, currentTime: DateTime.now());
                                        },
                                        child: Text(
                                          'When?',
                                          style: TextStyle(color: Colors.white),
                                        )
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: Sizes.dimen_6.h,
                                    ),
                                    textAlign:  TextAlign.center,
                                    controller: dateTimeLabelController,
                                    readOnly: true,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                RadiantGradientMask(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))
                    ),
                    child: GestureDetector(
                      onTap: (){
                        if(dateTimeController.text.isEmpty){
                          dateTimeLabelController.text = 'Pick a date';
                        }
                        if(formKey.currentState.validate()){
                          formKey.currentState.save();
                          BlocProvider.of<WatchAlongFormBloc>(context).add(
                            WatchAlongSubmitEvent(
                                location: whereController.text,
                                movieID: widget.movieID,
                                scheduledTime: DateTime.parse(dateTimeController.text),
                                title: titleController.text),
                          );
                          Navigator.pop(context);
                        };
                        },
                      child:
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                              fontSize: Sizes.dimen_6.h,
                              fontWeight: FontWeight.w500
                            ) ,),
                        ) ,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return(Text('Undefined State In WatchAlongForm'));
        },
    );
  }
}
