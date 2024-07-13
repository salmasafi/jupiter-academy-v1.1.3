import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/styles.dart';

class TimeNowContainer extends StatelessWidget {
  const TimeNowContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${DateTime.now().day.toString()} ${DateFormat('MMMM yyyy').format(DateTime.now())}',
            style: Styles.style16,
          ),
        ),
        StreamBuilder(
          stream: Stream.periodic(
            const Duration(seconds: 1),
          ),
          builder: (context, snapshot) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('hh:mm:ss a').format(DateTime.now()).toString(),
                style: Styles.style18,
              ),
            );
          },
        ),
      ],
    );
  }
}
