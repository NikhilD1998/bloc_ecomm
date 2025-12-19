import 'package:bloc_ecomm/models/product_model.dart';
import 'package:bloc_ecomm/theme/app_colors.dart';
import 'package:bloc_ecomm/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: Navigate to product details
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.imageUrl.startsWith('http')
                      ? Image.network(product.imageUrl, fit: BoxFit.cover)
                      : Image.asset(product.imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                style: AppTextStyles.bodyText14.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.bodyText14.copyWith(
                  color: AppColors.activatedButtonContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toString(),
                    style: AppTextStyles.bodyText12,
                  ),
                  const Spacer(),
                  if (!product.inStock)
                    Text(
                      'Out of stock',
                      style: AppTextStyles.bodyText12.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
