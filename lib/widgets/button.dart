// In lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:spsole/widgets/mycolors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSubmit;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSubmit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        width: 270,
        height: 45,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
