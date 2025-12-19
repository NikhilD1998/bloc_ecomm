import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/dummy_data.dart';
import '../../models/product_model.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/primary_button.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';

class ProductInfoScreen extends StatefulWidget {
  final String productId;
  const ProductInfoScreen({required this.productId, super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productMap = dummyProducts.firstWhere(
      (p) => p['id'] == widget.productId,
    );
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
            Row(
              children: [
                Text('Quantity:', style: AppTextStyles.bodyText14),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.fieldsBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.fieldsSelectedStroke,
                      width: 1.5,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _quantity,
                      items: List.generate(
                        10,
                        (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text(
                            '${i + 1}',
                            style: AppTextStyles.bodyText14,
                          ),
                        ),
                      ),
                      onChanged: product.inStock
                          ? (val) {
                              if (val != null) setState(() => _quantity = val);
                            }
                          : null,
                      dropdownColor: AppColors.fieldsBackground,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.activatedButtonContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Add to Cart',
              onPressed: product.inStock
                  ? () {
                      print(
                        'ProductInfoScreen: Add to Cart pressed for productId=${product.id}, quantity=$_quantity',
                      );
                      context.read<CartBloc>().add(
                        AddItem(product.id, quantity: _quantity),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart'),
                          backgroundColor: AppColors.snackBarContainer,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
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
