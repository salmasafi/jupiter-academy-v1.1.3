// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/build_appbar_method.dart';
import '../../../../core/widgets/mybutton.dart';
import '../../../../core/widgets/mytextfield.dart';
import '../../../home/presentation/views/homescreen.dart';
import '../../logic/models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: myLightGrey,
      appBar: buildAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        children: [
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Center(
            child: Text('Login', style: Styles.style42),
          ),
          Center(
            child: Text(
              'login to your account',
              style: Styles.style18Bold,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          MyTextField(
            fieldType: 'UserName',
            text: 'USERNAME',
            icon: Icons.person,
            onChanged: (value) {
              email = value;
            },
          ),
          MyTextField(
            fieldType: 'Password',
            text: 'PASSWORD',
            icon: Icons.lock,
            isObsecure: true,
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          MyButton(
            title: 'LOGIN',
            onPressed: () async {
              if (email != null &&
                  email!.isNotEmpty &&
                  password != null &&
                  password!.isNotEmpty) {
                try {
                  String id =
                      await APiService().getUserIdByLogin(email!, password!);

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('userId', id);

                  final fCMToken = await FirebaseMessaging.instance.getToken();

                  DocumentReference employeeDoc = FirebaseFirestore.instance
                      .collection('Employees')
                      .doc(id);

                  print(fCMToken);

                  await employeeDoc.update({
                    'fCMToken': fCMToken,
                  });

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FutureBuilder<UserModel>(
                        future: APiService().getUserById(id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            return HomeScreen(userModel: snapshot.data!);
                          } else {
                            return const LoginScreen();
                          }
                        },
                      ),
                    ),
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Login failed: ${e.toString()}',
                      ),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please type a valid email or password',
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
        ],
      ),
    );
  }
}
