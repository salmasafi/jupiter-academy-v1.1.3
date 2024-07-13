import 'package:flutter/material.dart';
import '../utils/constants.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: myPurple,
    centerTitle: true,
    title: LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final imageSize = screenWidth * 0.5;

        return SizedBox(
          height: imageSize,
          width: imageSize,
          child: Image.asset(
            'assets/images/Jupiter.png',
            fit: BoxFit.contain,
          ),
        );
      },
    ),
  );
}
