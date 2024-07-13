import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';

class CheckOutTextField extends StatelessWidget {
  const CheckOutTextField({
    super.key,
    required TextEditingController controller,
    required this.onChanged,
  }) : _controller = controller;

  final TextEditingController _controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Type your checkout here.......',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: myPurple),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
