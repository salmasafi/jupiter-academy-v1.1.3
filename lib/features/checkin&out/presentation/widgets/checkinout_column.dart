import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class CheckInOutColumn extends StatelessWidget {
  const CheckInOutColumn({
    super.key,
    required this.check,
    required this.title,
  });

  final String title;
  final String check;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Styles.style20,
        ),
        Text(
          check,
          style: Styles.style20,
        ),
      ],
    );
  }
}
