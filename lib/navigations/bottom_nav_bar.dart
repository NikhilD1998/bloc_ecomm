import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBodyForIndex(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Home'));
      case 1:
        return const Center(child: Text('Cart'));
      case 2:
        return const Center(child: Text('Profile'));
      default:
        return const Center(child: Text('Home'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyForIndex(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        backgroundColor: AppColors.screenBackground,
        selectedItemColor: AppColors.activatedButtonContainer,
        unselectedItemColor: AppColors.unselectedFieldsFont,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
