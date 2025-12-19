import 'package:bloc_ecomm/models/product_model.dart';
import 'package:bloc_ecomm/screens/main/product_info_screen.dart';
import 'package:bloc_ecomm/widgets/product_screen/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_event.dart';
import '../../blocs/product/product_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

enum ProductSort { none, priceLowHigh, priceHighLow, nameAZ, nameZA }

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductSort _sort = ProductSort.none;

  List<ProductModel> _sortProducts(List<ProductModel> products) {
    switch (_sort) {
      case ProductSort.priceLowHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSort.priceHighLow:
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSort.nameAZ:
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProductSort.nameZA:
        products.sort((a, b) => b.title.compareTo(a.title));
        break;
      case ProductSort.none:
      default:
        break;
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc()..add(LoadProducts()),
      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        appBar: AppBar(
          title: Text('Products', style: AppTextStyles.mainHeading),
          backgroundColor: AppColors.screenBackground,
          elevation: 0,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              List<ProductModel> products = List.of(state.products);
              products = _sortProducts(products);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: AppColors.activatedButtonContainer,
                        ),
                        const SizedBox(width: 8),
                        Text('Sort by:', style: AppTextStyles.bodyText14),
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
                            child: DropdownButton<ProductSort>(
                              value: _sort,
                              items: const [
                                DropdownMenuItem(
                                  value: ProductSort.none,
                                  child: Text('None'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSort.priceLowHigh,
                                  child: Text('Price: Low to High'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSort.priceHighLow,
                                  child: Text('Price: High to Low'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSort.nameAZ,
                                  child: Text('Name: A-Z'),
                                ),
                                DropdownMenuItem(
                                  value: ProductSort.nameZA,
                                  child: Text('Name: Z-A'),
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _sort = val);
                              },
                              style: AppTextStyles.bodyText14,
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
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.fieldsUnselectedStroke,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<ProductBloc>().add(RefreshProducts());
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductInfoScreen(productId: product.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
