import 'package:flutter/material.dart';
import 'package:jupiter_academy/core/widgets/build_appbar_method.dart';
import '../utils/constants.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'Oops, There\'s a problem, try again',
          style: TextStyle(color: myPurple),
        ),
      ),
    );
  }
}
