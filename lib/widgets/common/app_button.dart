import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final bool loading;
  final bool enabled;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.loading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(label);
    final buttonHeight = 48.0;

    final buttonChild = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          )
        : textWidget;

    final button = SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: outlined
          ? OutlinedButton(
              onPressed: (enabled && !loading) ? onPressed : null,
              child: buttonChild,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, buttonHeight),
              ),
            )
          : ElevatedButton(
              onPressed: (enabled && !loading) ? onPressed : null,
              child: buttonChild,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, buttonHeight),
              ),
            ),
    );

    return button;
  }
}
