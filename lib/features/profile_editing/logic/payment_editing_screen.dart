// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../core/api/api_service.dart';
import '../../../core/utils/styles.dart';
import '../../../core/widgets/build_appbar_method.dart';
import '../../../core/widgets/mybutton.dart';
import '../../../core/widgets/mytextfield.dart';
import '../../login/logic/models/user_model.dart';

class PaymentEditingScreen extends StatefulWidget {
  final UserModel userModel;

  const PaymentEditingScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<PaymentEditingScreen> createState() => _PasswordEditingScreenState();
}

class _PasswordEditingScreenState extends State<PaymentEditingScreen> {
  String cardNumber = '';

  String cardHolderName = '';

  editPaymentInfo() async {
    bool result = await APiService().changePaymentInfo(
      userModel: widget.userModel,
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'PaymentInfo have changed successfully',
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
                'Edit payment information',
                style: Styles.style22,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            MyTextField(
              fieldType: 'Text',
              text: 'Instapay/CardNumber/VFCash',
              onChanged: (value) {
                cardNumber = value;
              },
            ),
            MyTextField(
              fieldType: 'Text',
              text: 'Card Holder Name',
              onChanged: (value) {
                cardHolderName = value;
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            MyButton(
              title: 'SUBMIT',
              onPressed: () {
                if (cardNumber != '' && cardHolderName != '') {
                  editPaymentInfo();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'PaymentInformation can not be empty',
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
