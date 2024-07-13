import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';
import '../views/checkinout_screen.dart';

class CheckOutWelcomeContainer extends StatelessWidget {
  const CheckOutWelcomeContainer({
    super.key,
    required this.screenHeight,
    required this.widget,
  });

  final double screenHeight;
  final CheckInOutScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: screenHeight * 0.02),
          child: Text(
            'Welcome!',
            style: Styles.style25,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.userModel.name,
            style: Styles.style25,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Today\'s Status',
            style: Styles.style25,
          ),
        ),
      ],
    );
  }
}
