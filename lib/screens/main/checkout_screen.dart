import 'dart:math';
import 'package:bloc_ecomm/widgets/checkout_screen/order_summary.dart';
import 'package:bloc_ecomm/widgets/checkout_screen/review_cart.dart';
import 'package:bloc_ecomm/widgets/checkout_screen/shipping_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../models/order_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/primary_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Shipping form
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _city = '';
  String _zip = '';
  String? _orderId;

  String _generateOrderId() {
    final rand = Random();
    final num = rand.nextInt(9000) + 1000;
    return 'ORD-2025-$num';
  }

  void _nextStep() {
    if (_currentStep == 1 && !_formKey.currentState!.validate()) return;
    setState(() {
      _currentStep++;
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _pageController.animateToPage(
          _currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }
  }

  Future<void> _saveOrderToHive(CartLoaded state) async {
    final orderBox = await Hive.openBox<OrderModel>('orders');
    final orderId = _generateOrderId();
    final order = OrderModel(
      id: orderId,
      name: _name,
      address: _address,
      city: _city,
      zip: _zip,
      items: state.items
          .map(
            (item) => OrderItem(
              id: item.id,
              title: item.title,
              price: item.price,
              quantity: item.quantity,
              imageUrl: item.imageUrl,
            ),
          )
          .toList(),
      total: state.total,
      date: DateTime.now(),
    );
    await orderBox.add(order);
    setState(() {
      _orderId = orderId;
    });
  }

  void _onNextPressed(CartLoaded state) async {
    if (_currentStep == 2) {
      // Place Order
      await _saveOrderToHive(state);
      context.read<CartBloc>().add(ClearCart());
      setState(() {
        _currentStep++;
        _pageController.animateToPage(
          _currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    } else if (_currentStep == 3) {
      // Done: Navigate to bottom nav bar (pop to root or use a named route)
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        Navigator.of(context).pushReplacementNamed('/'); // Adjust as needed
      }
    } else {
      _nextStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is! CartLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.screenBackground,
          appBar: AppBar(
            title: const Text('Checkout'),
            backgroundColor: AppColors.screenBackground,
            elevation: 0,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  // Progress indicator (4 steps)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: 32,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i <= _currentStep
                                ? AppColors.activatedButtonContainer
                                : AppColors.fieldsUnselectedStroke,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // Step 1: Review Cart
                        ReviewCartStep(
                          items: state.items,
                          subtotal: state.subtotal,
                          tax: state.tax,
                          total: state.total,
                        ),
                        // Step 2: Shipping Address
                        ShippingStep(
                          formKey: _formKey,
                          onNameChanged: (v) => _name = v,
                          onAddressChanged: (v) => _address = v,
                          onCityChanged: (v) => _city = v,
                          onZipChanged: (v) => _zip = v,
                        ),
                        // Step 3: Order Summary & Confirm
                        OrderSummaryStep(
                          name: _name,
                          address: _address,
                          city: _city,
                          zip: _zip,
                          items: state.items,
                          total: state.total,
                          orderId: _orderId ?? _generateOrderId(),
                        ),
                        // Step 4: Order Placed Confirmation
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.activatedButtonContainer,
                              size: 80,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Order Placed!',
                              style: AppTextStyles.mainHeading,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Your order has been placed successfully.',
                              style: AppTextStyles.bodyText14,
                            ),
                            const SizedBox(height: 24),
                            Text('Order ID:', style: AppTextStyles.bodyText14),
                            const SizedBox(height: 4),
                            Text(
                              _orderId ?? '',
                              style: AppTextStyles.headingMedium.copyWith(
                                color: AppColors.activatedButtonContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (_currentStep > 0 && _currentStep < 3)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _prevStep,
                              child: const Text('Back'),
                            ),
                          ),
                        if (_currentStep > 0 && _currentStep < 3)
                          const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            label: _currentStep == 2
                                ? 'Place Order'
                                : _currentStep == 3
                                ? 'Done'
                                : 'Next',
                            onPressed: () => _onNextPressed(state),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
