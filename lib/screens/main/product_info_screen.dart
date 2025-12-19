import 'package:flutter/material.dart';
import '../../helpers/dummy_data.dart';
import '../../models/product_model.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/primary_button.dart'; // <-- Import PrimaryButton

class ProductInfoScreen extends StatelessWidget {
  final String productId;
  const ProductInfoScreen({required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    final productMap = dummyProducts.firstWhere((p) => p['id'] == productId);
    final product = ProductModel.fromMap(productMap);

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(product.title, style: AppTextStyles.headingRegular),
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: product.imageUrl.startsWith('http')
                  ? Image.network(product.imageUrl, fit: BoxFit.cover)
                  : Image.asset(product.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Text(product.title, style: AppTextStyles.mainHeading),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.activatedButtonContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  product.rating.toString(),
                  style: AppTextStyles.bodyText14,
                ),
                const Spacer(),
                if (!product.inStock)
                  Text(
                    'Out of stock',
                    style: AppTextStyles.bodyText14.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    'In stock',
                    style: AppTextStyles.bodyText14.copyWith(
                      color: AppColors.activatedButtonContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Add to Cart',
              onPressed: product.inStock
                  ? () {
                      // TODO: Add to cart via CartBloc
                    }
                  : () {},
              enabled: product.inStock,
            ),
          ],
        ),
      ),
    );
  }
}
