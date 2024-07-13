// ignore_for_file: avoid_print, body_might_complete_normally_nullable
import 'package:jupiter_academy/core/api/firebase_api.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/notification_api.dart';
import '../../../../core/widgets/mybutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/build_appbar_method.dart';
import '../../../login/logic/models/user_model.dart';
import '../../logic/calculatetime_method.dart';
import '../widgets/checkinout_column.dart';
import '../widgets/checkout_textfield.dart';
import '../widgets/checkout_welcome_container.dart';
import '../widgets/good_job_container.dart';
import '../widgets/my_alert_dialog.dart';
import '../widgets/myslidebar.dart';
import '../widgets/timenow_container.dart';
import '../widgets/total_work_time_container.dart';

class CheckInOutScreen extends StatefulWidget {
  final UserModel userModel;
  const CheckInOutScreen({super.key, required this.userModel});

  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  //File? image;
  //final _picker = ImagePicker();

  bool showSpinner = true;
  bool isCheckOutDone = false;
  bool showTextField = false;

  String checkIn = '--/--';
  String checkOut = '--/--';

  String checkOutDetails = '.....';
  String checkOutDetailsTemp = '......';
  Map<String, dynamic> totalWorkTime = {};

  String? token;
  String? token2;

  TextEditingController _controller = TextEditingController();
  final GlobalKey<SlideActionState> key = GlobalKey();

  @override
  void initState() {
    _getCheckInOuts();
    _getManagerToken();
    _getMyToken();
    _loadSavedText();
    super.initState();
  }

  _getCheckInOuts() async {
    try {
      DocumentSnapshot employeeSnapshot =
          await EmployeeDoc.getEmployeeSnapshotForToday(
              id: widget.userModel.id);
      if (employeeSnapshot.exists) {
        if (employeeSnapshot['checkOutDetails'] == '......') {
          isCheckOutDone = false;
          showTextField = true;
        } else if (employeeSnapshot['checkOut'] == '--/--') {
          isCheckOutDone = false;
          showTextField = true;
        } else {
          isCheckOutDone = true;
          showTextField = false;
        }
        setState(() {
          checkIn = employeeSnapshot['checkIn'];
          checkOut = employeeSnapshot['checkOut'];
          totalWorkTime = employeeSnapshot['totalWorkTime'];
        });
        print(
            'Data fetched successfully: checkIn: $checkIn, checkOut: $checkOut, totalWorkTime: $totalWorkTime');

        showSpinner = false;
      } else {
        setState(() {
          checkIn = '--/--';
          checkOut = '--/--';
          totalWorkTime = {'hours': 0, 'minutes': 0};
          showSpinner = false;
        });
        print('Document does not exist.');
      }
    } catch (e) {
      checkIn = '--/--';
      checkOut = '--/--';
      totalWorkTime = {'hours': 0, 'minutes': 0};

      print('Error fetching data: $e');
      setState(() {});
    }
  }

  _getManagerToken() async {
    try {
      DocumentSnapshot managerDoc = await FirebaseFirestore.instance
          .collection('Employees')
          .doc('670b2538-9ff7-414d-9f21-dbe7b6bfa8a9')
          .get();

      if (!managerDoc.exists) {
        throw Exception('Manager not found');
      }

      print('Manager data: ${managerDoc.data()}');

      Map<String, dynamic> managerData =
          managerDoc.data() as Map<String, dynamic>;

      if (managerData.containsKey('fCMToken')) {
        token = managerData['fCMToken'];
      }

      print('Fetching manager token done $token');
    } catch (e) {
      print('Error fetching manager token: $e');
    }
  }

  _getMyToken() async {
    try {
      DocumentSnapshot managerDoc = await FirebaseFirestore.instance
          .collection('Employees')
          .doc('d666da61-11ed-48d2-bee7-f994d85e6be0')
          .get();

      if (!managerDoc.exists) {
        throw Exception('Manager not found');
      }

      print('Manager data: ${managerDoc.data()}');

      Map<String, dynamic> managerData =
          managerDoc.data() as Map<String, dynamic>;

      if (managerData.containsKey('fCMToken')) {
        token2 = managerData['fCMToken'];
      }

      print('token is $token2');

      print('Fetching manager token done');
    } catch (e) {
      print('Error fetching manager token: $e');
    }
  }

  Future<void> _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final lastCheckOutDate =
        prefs.getString('checkOutDetailsDate${widget.userModel.id}');

    if (lastCheckOutDate == DateFormat('dd MMMM yyyy').format(DateTime.now())) {
      setState(() {
        _controller.text =
            prefs.getString('checkOutDetails${widget.userModel.id}') ?? '';

        if (_controller.text == '') {
          showTextField = true;
        } else {
          showTextField = false;
        }
      });
    } else {
      _deleteText();
    }
  }

  Future<void> _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('checkOutDetails${widget.userModel.id}', text);
    await prefs.setString('checkOutDetailsDate${widget.userModel.id}',
        DateFormat('dd MMMM yyyy').format(DateTime.now()));
  }

  Future<void> _deleteText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('checkOutDetails${widget.userModel.id}');
    await prefs.remove('checkOutDetailsDate${widget.userModel.id}');
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    DocumentReference employeeDoc =
        EmployeeDoc.getEmployeeDocForToday(id: widget.userModel.id);

    Future<bool> _undoCheckIn() async {
      try {
        print('Trying to delete document and date');

        DocumentSnapshot employeeSnapshot = await employeeDoc.get();

        if (employeeSnapshot.exists) {
          await employeeDoc.delete();
          print('Document successfully deleted!');
          setState(() {
            checkIn = '--/--';
            showTextField = false;
            checkOutDetails = '......';
          });
          return true;
        } else {
          print('Document does not exist.');
          return false;
        }
      } catch (e) {
        print('Error deleting document: $e');
        return false;
      }
    }

    Future<bool> _undoCheckOut() async {
      try {
        DocumentSnapshot employeeSnapshot = await employeeDoc.get();

        if (employeeSnapshot.exists) {
          await employeeDoc.update({
            'checkOut': '--/--',
          });
          showTextField = true;
          isCheckOutDone = false;
          await _loadSavedText();
          print('Checkout successfully updated!');
          setState(() {
            checkOut = '--/--';
          });
          return true;
        } else {
          print('Checkout updating failed.');
          return false;
        }
      } catch (e) {
        print('Error updating checkout: $e');
        return false;
      }
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              CheckOutWelcomeContainer(
                  screenHeight: screenHeight, widget: widget),
              Container(
                height: screenHeight * 0.2,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: myPurple,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => MyAlertDialog(
                              title: 'Undo Check-In',
                              body: 'Do you want to undo your check-in?',
                              onYes: _undoCheckIn(),
                            ),
                          );
                        },
                        child: CheckInOutColumn(
                          title: 'Check In',
                          check: checkIn,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => MyAlertDialog(
                              title: 'Undo Check-Out',
                              body: 'Do you want to undo your check-out?',
                              onYes: _undoCheckOut(),
                            ),
                          );
                        },
                        child: CheckInOutColumn(
                          title: 'Check Out',
                          check: checkOut,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TimeNowContainer(),
              checkIn == '--/--' || checkOut == '--/--'
                  ? MySlideBar(
                      screenHeight: screenHeight,
                      checkIn: checkIn,
                      myKey: key,
                      onSubmit: () async {
                        key.currentState!.reset();
                        DocumentSnapshot employeeSnapshot =
                            await employeeDoc.get();

                        if (employeeSnapshot.exists) {
                          checkOut =
                              DateFormat('hh:mm a').format(DateTime.now());

                          totalWorkTime = calculateTimeDifference(
                            startTime: checkIn,
                            endTime: checkOut,
                          );

                          await employeeDoc.update({
                            'checkOut': checkOut,
                            'totalWorkTime': totalWorkTime,
                          });

                          /* NotificationApi().sendNotification(
                                body:
                                    '${widget.userModel.name} has checked out at ${DateFormat('hh:mm a').format(DateTime.now())}!',
                                title: 'New check-out!',
                                token: token!,
                                page: 'attendance',
                                employeeId: widget.userModel.id,
                                //Amira Gomaa
                              ); */

                          NotificationApi().sendNotification(
                            body:
                                '${widget.userModel.name} has checked out at ${DateFormat('hh:mm a').format(DateTime.now())}!',
                            title: 'New check-out!',
                            token: token2!,
                            page: 'attendance',
                            employeeId: widget.userModel.id,
                            //Salma Safi
                          );

                          setState(() {});
                        } else {
                          await employeeDoc.set({
                            'checkIn':
                                DateFormat('hh:mm a').format(DateTime.now()),
                            'checkOut': '--/--',
                            'totalWorkTime': {'hours': 0, 'minutes': 0},
                            'checkOutDetails': '......',
                            'rate': -1,
                          });

                          /*   NotificationApi().sendNotification(
                                body:
                                    '${widget.userModel.name} has checked in at ${DateFormat('hh:mm a').format(DateTime.now())}!',
                                title: 'New check-in!',
                                token: token!,
                                page: 'attendance',
                                employeeId: widget.userModel.id,
                                //Amira Gomaa
                              ); */

                          NotificationApi().sendNotification(
                            body:
                                '${widget.userModel.name} has checked in at ${DateFormat('hh:mm a').format(DateTime.now())}!',
                            title: 'New check-in!',
                            token: token2!,
                            page: 'attendance',
                            employeeId: widget.userModel.id,
                            //Salma Safi
                          );

                          setState(() {
                            showTextField = true;
                            checkOutDetails = '......';
                            checkIn =
                                DateFormat('hh:mm a').format(DateTime.now());
                          });
                        }
                      },
                    )
                  : TotalWorkTimeContainer(totalWorkTime: totalWorkTime),
              isCheckOutDone == false && showTextField == true
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        CheckOutTextField(
                          controller: _controller,
                          onChanged: (value) {
                            checkOutDetailsTemp = value;
                            _saveText(_controller.text);
                          },
                        ),
                        /* const SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.07,
                                    child: const Center(
                                      child: Text(
                                        'Pick an image',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                               */
                        const SizedBox(
                          height: 20,
                        ),
                        checkOut != '--/--'
                            ? MyButton(
                                title: 'SUBMIT',
                                onPressed: () async {
                                  checkOutDetails =
                                      (_controller.text != '......' ||
                                              _controller.text != '')
                                          ? _controller.text
                                          : '......';
                                  if (isCheckOutDone == false &&
                                      checkOutDetails != '......') {
                                    DocumentSnapshot employeeSnapshot =
                                        await employeeDoc.get();

                                    if (employeeSnapshot.exists) {
                                      await employeeDoc.update({
                                        'checkOutDetails': checkOutDetails,
                                      });

                                      checkOutDetails = '......';
                                      isCheckOutDone = true;
                                      setState(() {});
                                    }
                                  }
                                },
                              )
                            : const SizedBox()
                      ],
                    )
                  : checkOut != '--/--'
                      ? const GoodJobContainer()
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
