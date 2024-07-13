// ignore_for_file: unnecessary_cast, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jupiter_academy/core/widgets/my_list_tile.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/errorwidget.dart';
import '../../../../core/widgets/loadingwidget.dart';
import '../../../../core/widgets/build_appbar_method.dart';
import '../../logic/models/student_model.dart';

class StudentsScrennBuilder extends StatefulWidget {
  final String batchId;
  const StudentsScrennBuilder({super.key, required this.batchId});

  @override
  State<StudentsScrennBuilder> createState() => _StudentsScrennBuilderState();
}

class _StudentsScrennBuilderState extends State<StudentsScrennBuilder> {
  late Future<List<StudentModel>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture =
        APiService().getStudentsByBatchId(widget.batchId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _studentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoadingWidget();
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return const MyErrorWidget();
        } else if (!snapshot.hasData ||
            (snapshot.data as List<StudentModel>).isEmpty) {
          return Scaffold(
            appBar: buildAppBar(),
            body: const Center(
              child: Text('There are no students in this batch'),
            ),
          );
        } else {
          return StudentsScreen(
            studentsList: snapshot.data! as List<StudentModel>,
          );
        }
      },
    );
  }
}

class StudentsScreen extends StatelessWidget {
  final List<StudentModel> studentsList;
  const StudentsScreen({super.key, required this.studentsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Total students in this batch: ${studentsList.length}', style: Styles.style25,),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MySquareTile(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'name: ${studentsList[index].name}',
                            style: Styles.style24,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'jupiterCoins: ${studentsList[index].jupiterCoins}',
                            style: Styles.style24,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'phone: ${studentsList[index].phone}',
                            style: Styles.style24,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'whatsApp: ${studentsList[index].whatsApp}',
                            style: Styles.style24,
                          ),
                        ),
                  
                        
                      ],
                    ),
                  ),
                );
              },
              itemCount: studentsList.length,
            ),
          ],
        ),
      ),
    );
  }
}
