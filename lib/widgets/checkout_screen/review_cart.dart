import 'package:bloc_ecomm/theme/app_colors.dart';
import 'package:bloc_ecomm/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReviewCartStep extends StatelessWidget {
  final List items;
  final double subtotal, tax, total;
  const ReviewCartStep({
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Review Cart', style: AppTextStyles.headingRegular),
        const SizedBox(height: 16),
        ...items.map<Widget>(
          (item) => ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.imageUrl.startsWith('http')
                  ? Image.network(
                      item.imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      item.imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(item.title, style: AppTextStyles.bodyText14),
            subtitle: Text(
              'x${item.quantity}  \$${item.price.toStringAsFixed(2)}',
              style: AppTextStyles.bodyText12,
            ),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal:', style: AppTextStyles.bodyText14),
            Text(
              '\$${subtotal.toStringAsFixed(2)}',
              style: AppTextStyles.bodyText14,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax (5%):', style: AppTextStyles.bodyText14),
            Text(
              '\$${tax.toStringAsFixed(2)}',
              style: AppTextStyles.bodyText14,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total:', style: AppTextStyles.headingMedium),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.activatedButtonContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
