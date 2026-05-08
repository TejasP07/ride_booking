import 'package:flutter/material.dart';
import 'package:task_tejas/core/constants/app_colors.dart';

class OtpInputBox extends StatelessWidget {
  final TextEditingController controller;

  final FocusNode focusNode;

  final FocusNode? nextFocus;

  final FocusNode? previousFocus;

  const OtpInputBox({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.previousFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,

      child: TextField(
        controller: controller,

        focusNode: focusNode,

        keyboardType: TextInputType.number,

        textAlign: TextAlign.center,

        maxLength: 1,

        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: 'PlusJakartaSans',
        ),

        decoration: InputDecoration(
          counterText: '',

          filled: true,

          fillColor: AppColors.lightBgColor,

          contentPadding: EdgeInsets.symmetric(vertical: 13),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
        ),

        onChanged: (value) {
          if (value.isNotEmpty) {
            nextFocus?.requestFocus();
          } else {
            previousFocus?.requestFocus();
          }
        },
      ),
    );
  }
}
