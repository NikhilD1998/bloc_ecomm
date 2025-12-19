import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/auth/auth_event.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../auth/auth_screen.dart';
import '../../widgets/common/primary_button.dart';
import '../../models/order_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
  }

  Future<List<OrderModel>> _getOrders() async {
    final box = await Hive.openBox<OrderModel>('orders');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => curr is Unauthenticated,
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        appBar: AppBar(title: const Text('Profile')),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.activatedButtonContainer,
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          state.isGuest ? 'Guest User' : 'user@example.com',
                          style: AppTextStyles.mainHeading,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.isGuest
                              ? 'You are browsing as a guest.'
                              : 'Welcome back!',
                          style: AppTextStyles.bodyText14,
                        ),
                        if (!state.isGuest) ...[
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your Orders',
                              style: AppTextStyles.headingMedium,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FutureBuilder<List<OrderModel>>(
                            future: _getOrders(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final orders = (snapshot.data ?? []).reversed
                                  .toList();
                              if (orders.isEmpty) {
                                return Text(
                                  'No orders yet.',
                                  style: AppTextStyles.bodyText14,
                                );
                              }
                              return Column(
                                children: List.generate(orders.length, (index) {
                                  final order = orders[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      color: AppColors.fieldsBackground,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Order ID: ${order.id}',
                                              style: AppTextStyles.bodyText14
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .activatedButtonContainer,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Date: ${order.date.toLocal().toString().split(' ')[0]}',
                                              style: AppTextStyles.bodyText12
                                                  .copyWith(
                                                    color: AppColors
                                                        .unselectedFieldsFont,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Total: \$${order.total.toStringAsFixed(2)}',
                                              style: AppTextStyles.headingMedium
                                                  .copyWith(
                                                    color:
                                                        AppColors.mainHeading,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Items:',
                                              style: AppTextStyles.bodyText14
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            ...order.items.map(
                                              (item) => Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                  bottom: 2,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${item.quantity}x ',
                                                      style: AppTextStyles
                                                          .bodyText12,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.title,
                                                        style: AppTextStyles
                                                            .bodyText12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                                      style: AppTextStyles
                                                          .bodyText12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ],
                        const SizedBox(height: 32),
                        PrimaryButton(
                          label: 'Logout',
                          onPressed: () => _logout(context),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
