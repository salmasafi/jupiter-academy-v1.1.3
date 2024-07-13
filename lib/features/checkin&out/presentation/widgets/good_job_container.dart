import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';

class GoodJobContainer extends StatelessWidget {
  const GoodJobContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 16),
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
            'Good Job!, See you tomorrow',
            style: Styles.style25,
          ),
        ),
      );
  }
}
