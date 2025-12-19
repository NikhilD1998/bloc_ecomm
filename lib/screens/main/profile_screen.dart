import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/auth/auth_event.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../auth/auth_screen.dart';
import '../../widgets/common/primary_button.dart'; // <-- Import PrimaryButton

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
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
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.activatedButtonContainer,
                      child: Icon(Icons.person, size: 48, color: Colors.white),
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
                    const Spacer(),
                    PrimaryButton(
                      label: 'Logout',
                      onPressed: () => _logout(context),
                    ),
                  ],
                ),
              );
            } else {
              // Show nothing, navigation will happen via BlocListener
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
