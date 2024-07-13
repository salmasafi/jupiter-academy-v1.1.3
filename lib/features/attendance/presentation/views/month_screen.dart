import 'package:flutter/material.dart';
import 'package:jupiter_academy/core/utils/styles.dart';
import 'package:jupiter_academy/features/home/presentation/views/homescreen.dart';
import '../widget/rate_widget.dart';

class MonthDetailsScreen extends StatelessWidget {
  const MonthDetailsScreen({
    super.key,
    required this.checkInOuts,
    required this.id,
    required this.month,
  });

  final List<Map<String, dynamic>> checkInOuts;
  final String id;
  final String month;

  Map<String, dynamic> calculateMonthWorkTime(
      final List<Map<String, dynamic>> checkInOuts) {
    num totalMonthWorkTimeAsMinutes = 0;
    for (var checkInOut in checkInOuts) {
      totalMonthWorkTimeAsMinutes +=
          checkInOut['totalWorkTimeAsMinutes'] as int;
    }

    print(totalMonthWorkTimeAsMinutes);

    Map<String, dynamic> totalWorkTime = {'hours': 0, 'minutes': 0};

    while (totalMonthWorkTimeAsMinutes >= 60) {
      totalMonthWorkTimeAsMinutes -= 60;
      totalWorkTime['hours'] += 1;
    }

    totalWorkTime['minutes'] = totalMonthWorkTimeAsMinutes;

    return totalWorkTime;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                'Days: ${checkInOuts.length}, Hours: ${calculateMonthWorkTime(checkInOuts)['hours']}, Minutes: ${calculateMonthWorkTime(checkInOuts)['minutes']}',
                style: Styles.style20,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              // ignore: prefer_const_constructors
              physics: NeverScrollableScrollPhysics(),
              itemCount: checkInOuts.length,
              itemBuilder: (context, index) {
                final data = checkInOuts[index];
                return Card(
                  child: Row(
                    children: [
                      Flexible(
                        child: ListTile(
                          title: Text(
                            data['date'],
                            style: Styles.style18,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Check-In: ',
                                    style: Styles.style16Bold,
                                  ),
                                  Text(
                                    '${data['checkIn']}',
                                    style: Styles.style16,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Check-Out: ',
                                    style: Styles.style16Bold,
                                  ),
                                  Text(
                                    '${data['checkOut']}',
                                    style: Styles.style16,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Work Time: ',
                                    style: Styles.style16Bold,
                                  ),
                                  Text(
                                    '${data['totalWorkTime']['hours'] ?? 0} hours, ${data['totalWorkTime']['minutes'] ?? 0} minutes',
                                    style: Styles.style16,
                                  ),
                                ],
                              ),
                              Text(
                                'Check-Out-details:',
                                style: Styles.style16Bold,
                              ),
                              Text(
                                '${data['checkOutDetails']}',
                                style: Styles.style16,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ),
                      (thisUserId == id)
                          ? const SizedBox()
                           /* ApproveWidget(
                              userModel: userModel,
                              rate: checkInOuts[index]['rate'] as int,
                              month: month,
                            ) */
                          : RateWidget(
                              id: id,
                              rate: (checkInOuts[index]['rate']),
                              checkInOut: data,
                              month: month,
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
  }
}
