// ignore_for_file: library_private_types_in_public_api, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../presentation/views/attendance_screen.dart';

class AttendanceScreenBuilder extends StatefulWidget {
  final String id;
  const AttendanceScreenBuilder({super.key, required this.id});

  @override
  _AttendanceScreenBuilderState createState() =>
      _AttendanceScreenBuilderState();
}

class _AttendanceScreenBuilderState extends State<AttendanceScreenBuilder> {

  List<String> months = [];

  @override
  void initState() {
    super.initState();
    _getMonths();
  }

  _getMonths() async {
    print(widget.id);
    try {
      var monthsSnapshot = await FirebaseFirestore.instance
          .collection('Employees')
          .doc(widget.id)
          .collection('CheckInOuts')
          .get();

      List<String> monthsList = [];

      monthsSnapshot.docs.forEach((doc) {
        monthsList.add(doc.id);
      });

      setState(() {
        months = monthsList.toList();
      });

      print(months);
    } catch (e) {
      print('Error retrieving months: $e');
    }
  } 

  @override
  Widget build(BuildContext context) {
    return AttendanceScreen(months: months, id: widget.id,);
  }
}

