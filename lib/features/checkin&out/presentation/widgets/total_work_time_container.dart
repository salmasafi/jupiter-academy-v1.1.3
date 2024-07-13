import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';

class TotalWorkTimeContainer extends StatelessWidget {
  const TotalWorkTimeContainer({
    super.key,
    required this.totalWorkTime,
  });

  final Map<String, dynamic> totalWorkTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 32),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: myGrey,
              blurRadius: 50,
              offset: Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            'You have completed ${totalWorkTime['hours'] ?? 0} hours, ${totalWorkTime['minutes'] ?? 0} minutes of work!',
            style: Styles.style25,
          ),
        ),
      );
  }
}
