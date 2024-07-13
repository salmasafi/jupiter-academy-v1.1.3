import 'package:flutter/material.dart';

import 'build_appbar_method.dart';

class JupiterWidget extends StatelessWidget {
  const JupiterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/images/pxfuel.jpg',
          fit: BoxFit.cover,
        ),
      ), /* Center(
          child: SizedBox(
        height: 250,
        width: 250,
        child: Image.asset(
          'assets/images/logo.jpg',
          fit: BoxFit.fill,
        ),
      )),
     */
    );
  }
}
