import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_event.dart';
import '../../blocs/product/product_state.dart';
import '../../models/product_model.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc()..add(LoadProducts()),
      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        appBar: AppBar(title: const Text('Products')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              final products = state.products;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(RefreshProducts());
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns for mobile
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _ProductCard(product: product);
                  },
                ),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

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
