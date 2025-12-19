import 'package:bloc_ecomm/screens/main/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../auth/auth_screen.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/primary_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CartBloc>(context),
      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        appBar: AppBar(
          title: Text('My Cart', style: AppTextStyles.mainHeading),
          backgroundColor: AppColors.screenBackground,
          elevation: 0,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              print('CartScreen: CartLoaded with items: ${state.items}');
              final items = state.items;
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'Your cart is empty.',
                    style: AppTextStyles.bodyText14,
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(
                        color: AppColors.fieldsUnselectedStroke,
                        height: 24,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: item.imageUrl.startsWith('http')
                                  ? Image.network(
                                      item.imageUrl,
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      item.imageUrl,
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            title: Text(
                              item.title,
                              style: AppTextStyles.bodyText14,
                            ),
                            subtitle: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: AppTextStyles.bodyText12,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      UpdateQuantity(
                                        item.id,
                                        item.quantity - 1,
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: AppTextStyles.bodyText14,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      UpdateQuantity(
                                        item.id,
                                        item.quantity + 1,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      RemoveItem(item.id),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal:', style: AppTextStyles.bodyText14),
                            Text(
                              '\$${state.subtotal.toStringAsFixed(2)}',
                              style: AppTextStyles.bodyText14,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax (5%):', style: AppTextStyles.bodyText14),
                            Text(
                              '\$${state.tax.toStringAsFixed(2)}',
                              style: AppTextStyles.bodyText14,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Divider(color: AppColors.fieldsUnselectedStroke),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: AppTextStyles.headingMedium),
                            Text(
                              '\$${state.total.toStringAsFixed(2)}',
                              style: AppTextStyles.headingMedium.copyWith(
                                color: AppColors.activatedButtonContainer,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'Checkout',
                          onPressed: () {
                            final authState = context.read<AuthBloc>().state;
                            print(
                              'DEBUG: authState runtimeType = ${authState.runtimeType}',
                            );
                            print('DEBUG: authState = $authState');
                            if (authState is Unauthenticated ||
                                (authState is Authenticated &&
                                    authState.isGuest)) {
                              print(
                                'DEBUG: User is guest or unauthenticated, navigating to AuthScreen',
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AuthScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please log in to continue to checkout.',
                                  ),
                                ),
                              );
                            } else {
                              print(
                                'DEBUG: User is authenticated, navigating to CheckoutScreen',
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CheckoutScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            context.read<CartBloc>().add(ClearCart());
                          },
                          child: const Text('Clear Cart'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
