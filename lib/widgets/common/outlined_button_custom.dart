import 'package:bloc_ecomm/theme/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';

class OutlinedButtonCustom extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool loading;
  final bool enabled;

  const OutlinedButtonCustom({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 48.0;
    final buttonChild = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.activatedButtonContainer,
                ),
              ),
            ),
          )
        : Text(label);

    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: OutlinedButton(
        onPressed: (enabled && !loading) ? onPressed : null,
        child: buttonChild,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          side: const BorderSide(
            color: AppColors.activatedButtonContainer,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
