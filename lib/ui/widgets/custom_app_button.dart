import 'package:flutter/material.dart';
import 'package:talent_track/ui/common/app_colors.dart';
import 'package:talent_track/ui/common/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isEnabled;

  const CustomButton({super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.1),
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: isSelected
            ? AppTextStyles.positiveButtonText(context).copyWith(color: Colors.white)
            : !isEnabled ? AppTextStyles.negativeButtonText(context).copyWith(color: Colors.white)
            : AppTextStyles.positiveButtonText(context).copyWith(color: AppColors.primary),
      ),
    );
  }
}