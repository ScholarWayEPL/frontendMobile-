import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../injection_container.dart';
import '../state/auth_state.dart';
import '../widgets/auth_widgets.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const AuthScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  void _onTabChanged(int index) {
    if (_selectedTab == index) return;
    if (index == 0) {
      context.go('/login');
    } else {
      context.go('/register');
    }
  }

  void _onLogin(String email, String password) {
    ref
        .read(authNotifierProvider.notifier)
        .login(email: email, password: password);
  }

  void _onRegister(Map<String, String> data) {
    ref
        .read(authNotifierProvider.notifier)
        .registerBachelier(
          nom: data['nom']!,
          prenom: data['prenom']!,
          email: data['email']!,
          motDePasse: data['motDePasse']!,
          telephone: data['telephone']!,
        );
  }

  void _showError(String? error) {
    if (error != null) {
      AppSnackBar.show(context, message: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        if (_selectedTab == 1) {
          AppSnackBar.show(
            context,
            message: 'Compte créé avec succès !',
            isError: false,
          );
        } else {
          AppSnackBar.show(
            context,
            message: 'Connexion réussie !',
            isError: false,
          );
        }
      } else if (next is AuthError) {
        _showError(next.message);
      }
    });

    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeroSection(),
            _buildFormContainer(isLoading),
            const AuthFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(bool isLoading) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 35, 38),
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
        border: Border(
          top: BorderSide(color: AuthColors.accent, width: 3.w),
        ),
      ),
      child: Column(
        children: [
          AuthTabBar(selectedIndex: _selectedTab, onTabChanged: _onTabChanged),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: _selectedTab == 0
                ? LoginFormView(
                    key: const ValueKey('login'),
                    isLoading: isLoading,
                    onLogin: _onLogin,
                    onSocialGoogle: () {},
                    onSocialApple: () {},
                  )
                : RegisterFormView(
                    key: const ValueKey('register'),
                    isLoading: isLoading,
                    onRegister: _onRegister,
                    onSocialGoogle: () {},
                    onSocialApple: () {},
                    onError: _showError,
                  ),
          ),
          _buildBottomDecorativeLine(),
        ],
      ),
    );
  }

  Widget _buildBottomDecorativeLine() {
    return Container(
      height: 2.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AuthColors.accent,
            AuthColors.buttonGreen,
            AuthColors.accent,
          ],
        ),
      ),
    );
  }
}
