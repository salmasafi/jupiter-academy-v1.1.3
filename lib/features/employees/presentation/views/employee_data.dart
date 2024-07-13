/* import 'package:flutter/material.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/build_appbar_method.dart';
import '../../../../core/widgets/my_list_tile.dart';
import '../../../attendance/logic/attendance_screen_builder.dart';
import '../../../profile_editing/presentation/views/profilescreen.dart';
import '../../logic/models/employee_model.dart';

class EmployeeData extends StatelessWidget {
  final Employee employee;
  const EmployeeData({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MySquareTile(
                height: 220,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(userModel: employee),
                    ),
                  );
                },
                child: Text(
                  '${employee.name}\'s profile', style: Styles.style24,
                ),
              ),
              MySquareTile(
                height: 220,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceScreenBuilder(
                        userModel: employee,
                      ),
                    ),
                  );
                },
                child: Text(
                  '${employee.name}\'s checkouts', style: Styles.style24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */