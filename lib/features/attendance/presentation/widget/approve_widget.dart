// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../login/logic/models/user_model.dart';

class ApproveWidget extends StatefulWidget {
  final UserModel userModel;
  final String month;
  int rate;
  Widget myIcon = const Icon(Icons.check);
  ApproveWidget({
    super.key,
    required this.userModel,
    required this.rate,
    required this.month,
  });

  @override
  State<ApproveWidget> createState() => _ApproveWidgetState();
}

class _ApproveWidgetState extends State<ApproveWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.rate < 0) {
      widget.rate = 0;
      widget.myIcon = const Icon(Icons.pending);
    }
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          widget.myIcon,
          Text('${widget.rate}/10'),
        ],
      ),
    );
  }
}
