// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyTextField extends StatefulWidget {
  String fieldType;
  final String text;
  final IconData? icon;
  bool? isObsecure;
  void Function(String)? onChanged;
  MyTextField({
    super.key,
    required this.fieldType,
    required this.text,
    this.icon,
    this.isObsecure,
    this.onChanged,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      padding: EdgeInsets.only(left: screenWidth * 0.03),
      height: screenHeight * 0.085,
      width: double.infinity,
      decoration: BoxDecoration(
        color: myGrey,
        borderRadius: BorderRadius.circular(screenHeight * 0.02),
      ),
      child: TextField(
        style: TextStyle(
          fontSize: screenHeight * 0.025,
          color: myPurple,
        ),
        decoration: InputDecoration(
          labelText: widget.text,
          labelStyle: TextStyle(
            color: myPurple,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.023,
          ),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  size: screenHeight * 0.035,
                  color: myPurple,
                )
              : null,
          suffixIcon: widget.fieldType == 'Password'
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      if (widget.isObsecure == true) {
                        widget.isObsecure = false;
                      } else {
                        widget.isObsecure = true;
                      }
                    });
                  },
                )
              : null,
          border: InputBorder.none,
        ),
        obscureText: widget.isObsecure ?? false,
        onChanged: widget.onChanged,
      ),
    );
  }
}
