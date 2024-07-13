import 'package:flutter/material.dart';
import '../../../core/api/api_service.dart';
import '../../../core/widgets/errorwidget.dart';
import '../../../core/widgets/loadingwidget.dart';
import '../../../core/widgets/myemptyscreen.dart';
import 'models/employee_model.dart';
import '../presentation/views/employees_screen.dart';

class EmployeesScreenBuilder extends StatefulWidget {
  const EmployeesScreenBuilder({super.key});

  @override
  State<EmployeesScreenBuilder> createState() => _EmployeesScreenBuilderState();
}

class _EmployeesScreenBuilderState extends State<EmployeesScreenBuilder> {

  Future<List<Employee>> getEmployees() async {
    return await APiService().getEmployees();
  }

  @override
  Widget build(BuildContext context) {
return FutureBuilder<List<Employee>>(
      future: getEmployees(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoadingWidget();
        } else if (snapshot.hasData && snapshot.data != null) {
          return EmployeesScreen(employees: snapshot.data as List<Employee>);
         } else if (snapshot.hasError) {
          print(snapshot.error);
          return const MyErrorWidget();
        } else {
          return const EmptyScreen(title: 'employees');
        } 
      },
    );
  }
}
