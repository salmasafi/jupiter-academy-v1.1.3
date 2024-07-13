import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String body;
  final Future<bool> onYes;
  const MyAlertDialog({
    super.key,
    required this.title,
    required this.body,
    required this.onYes,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(body),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed: () async {
            bool result = await onYes;
            if (result == true) {
              Navigator.of(context).pop();
            }
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
