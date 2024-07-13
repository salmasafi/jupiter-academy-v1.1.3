import 'package:flutter/material.dart';

import 'build_appbar_method.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  const EmptyScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Text('There are no $title'),
      ),
    );
  }
}
