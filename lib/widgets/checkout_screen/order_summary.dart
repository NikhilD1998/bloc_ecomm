import 'package:bloc_ecomm/theme/app_colors.dart';
import 'package:bloc_ecomm/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderSummaryStep extends StatelessWidget {
  final String name, address, city, zip, orderId;
  final List items;
  final double total;
  const OrderSummaryStep({
    required this.name,
    required this.address,
    required this.city,
    required this.zip,
    required this.items,
    required this.total,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.activatedButtonContainer,
              size: 64,
            ),
            const SizedBox(height: 24),
            Text('Order Placed!', style: AppTextStyles.mainHeading),
            const SizedBox(height: 12),
            Text(
              'Thank you for your purchase.',
              style: AppTextStyles.bodyText14,
            ),
            const SizedBox(height: 24),
            Text('Order ID:', style: AppTextStyles.bodyText14),
            Text(
              orderId,
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.activatedButtonContainer,
              ),
            ),
            const SizedBox(height: 32),
            Text('Shipping to:', style: AppTextStyles.bodyText14),
            Text(
              '$name\n$address\n$city, $zip',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText14,
            ),
            const SizedBox(height: 32),
            Text(
              'Total Paid: \$${total.toStringAsFixed(2)}',
              style: AppTextStyles.headingMedium,
            ),
          ],
        ),
      ),
    );
  }
}
