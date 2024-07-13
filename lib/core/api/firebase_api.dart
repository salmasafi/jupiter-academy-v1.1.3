import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EmployeeDoc {

  static DocumentReference getEmployeeDocForToday({required id}) {
    DocumentReference employeeDoc = FirebaseFirestore.instance
        .collection('Employees')
        .doc(id)
        .collection('CheckInOuts')
        .doc(DateFormat('MMMM yyyy').format(DateTime.now()))
        .collection('Dates')
        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()));

    return employeeDoc;
  }

  static Future<DocumentSnapshot> getEmployeeSnapshotForToday({required id}) async {
    DocumentSnapshot employeeSnapshot = await EmployeeDoc.getEmployeeDocForToday(id: id).get();
    return employeeSnapshot;
  }
}
