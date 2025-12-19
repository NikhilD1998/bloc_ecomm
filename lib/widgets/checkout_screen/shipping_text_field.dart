import 'package:bloc_ecomm/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShippingTextField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const ShippingTextField({
    super.key,
    required this.label,
    this.validator,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: AppTextStyles.bodyText14,
    );
  }
}
