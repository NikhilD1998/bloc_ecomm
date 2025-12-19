import 'package:bloc_ecomm/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderSummaryStep extends StatelessWidget {
  final String name, address, city, zip;
  final List items;
  final double total;
  final String orderId;
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
            Text('Order Summary', style: AppTextStyles.mainHeading),
            const SizedBox(height: 16),
            Text('Shipping to:', style: AppTextStyles.bodyText14),
            Text(
              '$name\n$address\n$city, $zip',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText14,
            ),
            const SizedBox(height: 16),
            Text('Items:', style: AppTextStyles.bodyText14),
            ...items.map(
              (item) => Text(
                '${item.quantity}x ${item.title} - \$${(item.price * item.quantity).toStringAsFixed(2)}',
                style: AppTextStyles.bodyText12,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: AppTextStyles.headingMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Review your order and confirm to place it.',
              style: AppTextStyles.bodyText14,
            ),
          ],
        ),
      ),
    );
  }
}
