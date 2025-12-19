import 'package:bloc_ecomm/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShippingStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onNameChanged,
      onAddressChanged,
      onCityChanged,
      onZipChanged;
  const ShippingStep({
    required this.formKey,
    required this.onNameChanged,
    required this.onAddressChanged,
    required this.onCityChanged,
    required this.onZipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Shipping Address', style: AppTextStyles.headingRegular),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Enter your name' : null,
              onChanged: onNameChanged,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (v) => v == null || v.isEmpty ? 'Enter address' : null,
              onChanged: onAddressChanged,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'City'),
              validator: (v) => v == null || v.isEmpty ? 'Enter city' : null,
              onChanged: onCityChanged,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ZIP Code'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Enter ZIP code' : null,
              onChanged: onZipChanged,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
