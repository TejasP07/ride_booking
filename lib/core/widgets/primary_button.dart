import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final bool isEnabled;

  final bool isLoading;

  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.title,
    this.isEnabled = true,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: isLoading || isEnabled == false ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.primary : Colors.grey.shade400,
        ),
        child:
            isLoading
                ? const SizedBox(
                  width: 24,
                  height: 24,

                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                : Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
