// ignore_for_file: must_be_immutable, use_build_context_synchronously

import '../../../core/api/api_service.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/styles.dart';
import '../../../core/widgets/build_appbar_method.dart';
import '../../../core/widgets/mybutton.dart';
import '../../../core/widgets/mytextfield.dart';
import '../../login/logic/models/user_model.dart';

class PasswordEditingScreen extends StatefulWidget {
  final UserModel userModel;

  const PasswordEditingScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<PasswordEditingScreen> createState() => _PasswordEditingScreenState();
}

class _PasswordEditingScreenState extends State<PasswordEditingScreen> {
  String? oldPassword;

  String? newPassword;

  String? confirmNewPassword;

  changePassword() async {
    String result = await APiService()
        .changePassword(widget.userModel.id, oldPassword!, newPassword!);

    if (result == 'Done') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password have changed successfully',
          ),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'There\'s an error, Please try again',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
          children: [
            SizedBox(height: screenHeight * 0.1),
            Center(
              child: Text(
                'Change your password',
                style: Styles.style25,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            MyTextField(
              fieldType: 'Password',
              text: 'Old Password',
              icon: Icons.lock,
              isObsecure: true,
              onChanged: (value) {
                oldPassword = value;
              },
            ),
            MyTextField(
              fieldType: 'Password',
              text: 'New Password',
              icon: Icons.lock,
              isObsecure: true,
              onChanged: (value) {
                newPassword = value;
              },
            ),
            MyTextField(
              fieldType: 'Password',
              text: 'Confirm New Password',
              icon: Icons.lock,
              isObsecure: true,
              onChanged: (value) {
                confirmNewPassword = value;
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            MyButton(
              title: 'SUBMIT',
              onPressed: () {
                if (oldPassword != null &&
                    oldPassword != '' &&
                    newPassword != null &&
                    newPassword != '' &&
                    confirmNewPassword != null &&
                    confirmNewPassword != '') {
                  if (newPassword != confirmNewPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Confirmed password is not the same, Please type the same password',
                        ),
                      ),
                    );
                  } else if (oldPassword == newPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Old password and new one can not be the same, Please choose another password',
                        ),
                      ),
                    );
                  } else {
                    changePassword();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Password can not be empty, Please type a password',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
