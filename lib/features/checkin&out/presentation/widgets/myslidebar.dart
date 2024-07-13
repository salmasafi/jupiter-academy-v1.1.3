import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';

class MySlideBar extends StatelessWidget {
  const MySlideBar({
    required this.screenHeight,
    required this.checkIn,
    required this.onSubmit,
    required this.myKey,
  });

  final double screenHeight;
  final String checkIn;
  final GlobalKey<SlideActionState> myKey;
  final Future<dynamic>? Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.03),
      child: Builder(
        builder: (context) {
          return SlideAction(
            outerColor: myPurple.withOpacity(0.5),
            text:
                checkIn == '--/--' ? 'Slide to Check In' : 'Slide to Check Out',
            textStyle: Styles.style20,
            key: myKey,
            onSubmit: onSubmit,
          );
        },
      ),
    );
  }
}
