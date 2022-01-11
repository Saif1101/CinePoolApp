import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/journeys/timeline/AvatarCircle.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';



class FacePile extends StatefulWidget {
  const FacePile({
    Key key,
    @required this.users,
    this.faceSize = 48,
    this.facePercentOverlap = 0.1, //percentage overlap
  }) : super(key: key);

  final List<UserModel> users;
  final double faceSize;
  final double facePercentOverlap;

  @override
  _FacePileState createState() => _FacePileState();
}

class _FacePileState extends State<FacePile> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();



  }


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final facesCount = widget.users.length;

        double facePercentVisible = 1.0 - widget.facePercentOverlap;

        final maxIntrinsicWidth =
        facesCount > 1 ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize : widget.faceSize;

        double leftOffset;

        if (maxIntrinsicWidth > constraints.maxWidth) {
          leftOffset = 0;
          facePercentVisible = ((constraints.maxWidth / widget.faceSize) - 1) / (facesCount - 1);
        } else {
          leftOffset = (constraints.maxWidth - maxIntrinsicWidth) / 2;
        }

        if (constraints.maxWidth < widget.faceSize) {
          // There isn't room for a single face. Show nothing.
          return const SizedBox();
        }

        return SizedBox(
          height: widget.faceSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < facesCount; i += 1)
                Positioned(
                  top: 0,
                  height: widget.faceSize,
                  left: leftOffset + (i * facePercentVisible * widget.faceSize),
                  width: widget.faceSize,
                  child: AvatarCircle(
                    user: widget.users[i],
                    nameLabelColor: const Color(0xFF222222),
                    backgroundColor: const Color(0xFF888888),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
