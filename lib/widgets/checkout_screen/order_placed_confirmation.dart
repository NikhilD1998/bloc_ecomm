import 'package:flutter/material.dart';
import 'package:bloc_ecomm/theme/app_colors.dart';
import 'package:bloc_ecomm/theme/app_text_styles.dart';

class OrderPlacedConfirmation extends StatelessWidget {
  final String orderId;
  const OrderPlacedConfirmation({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.activatedButtonContainer,
            size: 80,
          ),
          const SizedBox(height: 24),
          Text('Order Placed!', style: AppTextStyles.mainHeading),
          const SizedBox(height: 12),
          Text(
            'Your order has been placed successfully.',
            style: AppTextStyles.bodyText14,
          ),
          const SizedBox(height: 24),
          Text('Order ID:', style: AppTextStyles.bodyText14),
          const SizedBox(height: 4),
          Text(
            orderId,
            style: AppTextStyles.headingMedium.copyWith(
              color: AppColors.activatedButtonContainer,
            ),
          ),
        ],
      ),
    );
  }
}
