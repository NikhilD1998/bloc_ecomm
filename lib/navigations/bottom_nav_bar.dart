import 'package:bloc_ecomm/screens/main/products_screen.dart';
import 'package:bloc_ecomm/screens/main/profile_screen.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _getBodyForIndex(int index) {
    switch (index) {
      case 0:
        return const ProductsScreen();
      case 1:
        return const Center(child: Text('Cart'));
      case 2:
        return const ProfileScreen();
      default:
        return const ProductsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _getBodyForIndex(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.screenBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onNavTap,
            backgroundColor: AppColors.screenBackground,
            selectedItemColor: AppColors.activatedButtonContainer,
            unselectedItemColor: AppColors.unselectedFieldsFont,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedLabelStyle: AppTextStyles.bodyText14.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.activatedButtonContainer,
            ),
            unselectedLabelStyle: AppTextStyles.bodyText14.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.unselectedFieldsFont,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  size: _selectedIndex == 0 ? 28 : 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 1
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  size: _selectedIndex == 1 ? 28 : 24,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 2 ? Icons.person : Icons.person_outline,
                  size: _selectedIndex == 2 ? 28 : 24,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
