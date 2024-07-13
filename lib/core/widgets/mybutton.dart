import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const MyButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      width: double.infinity,
      height: screenWidth * 0.18,
      decoration: BoxDecoration(
        color: myPurple,
        borderRadius: BorderRadius.circular(screenWidth * 0.1), // نسبة من عرض الشاشة لتحديد الزوايا
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: myLightGrey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
