import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/common/constants/size_constants.dart';
import 'package:socialentertainmentclub/common/extensions/size_extensions.dart';
import 'package:socialentertainmentclub/common/screenutil/screenutil.dart';
import 'package:socialentertainmentclub/helpers/theme_colors.dart';
import 'package:socialentertainmentclub/journeys/search/skew_cuts.dart';

class CustomRadio extends StatefulWidget {
  final Function onTapUser;
  final Function onTapMovie;


  const CustomRadio({Key key, @required this.onTapUser,@required this.onTapMovie}) : super(key: key);

  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData=[];

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Users',));
    sampleData.add(new RadioModel(true, 'Movies',));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.dimen_24.h,
      width: ScreenUtil.screenWidth,
      child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sampleData.length,
          itemBuilder: (BuildContext context, int index) {
            return ClipPath(

              clipper: index==0?SkewCutRight():SkewCutLeft(),
              child: new InkWell(
                //highlightColor: Colors.red,
                splashColor: Colors.blueAccent,
                onTap: () {
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;
                  });
                  if(sampleData[index].buttonText =='Users'){
                    widget.onTapUser();
                  } else {
                    widget.onTapMovie();
                  }
                },
                child: new RadioItem(sampleData[index]),
              ),
            );
          },
        ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(

      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(

            height: 24,
            width: ScreenUtil.screenWidth/2,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.pinkAccent,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                  fontWeight: FontWeight.w500)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.blueAccent
                  : ThemeColors.vulcan,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.blueAccent
                      :  Colors.pinkAccent),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  RadioModel(this.isSelected, this.buttonText);
}
