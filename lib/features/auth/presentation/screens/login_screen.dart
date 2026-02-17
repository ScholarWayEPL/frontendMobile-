import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../state/auth_state.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  int _selectedTab = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ref
        .read(authNotifierProvider.notifier)
        .login(email: email, password: password);
  }

  void _onTabChanged(int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/register');
      return;
    }
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;

    // Écouter les changements d'état pour navigation/erreurs
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        // TODO: Naviguer vers le home
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // === Section Hero avec image de fond ===
            _buildHeroSection(),

            // === Section formulaire ===
            _buildFormCard(isLoading),

            // === Footer ===
            const AuthFooter(),
          ],
        ),
      ),
    );
  }

  /// Section hero avec l'image de fond, le logo et le slogan
  Widget _buildHeroSection() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20.h,
            left: 28.w,
            right: 28.w,
            bottom: 40.h,
          ),
          decoration: const BoxDecoration(
            color: AuthColors.background,
            image: DecorationImage(
              image: AssetImage('assets/images/academic_bg.png'),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: const AuthHeader(),
        ),
        // Gradient overlay pour fondu vers le bas
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 60.h,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00091A16), AuthColors.background],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Carte de formulaire avec bordure gradient
  Widget _buildFormCard(bool isLoading) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 35, 38),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r),
          topRight: Radius.circular(18.r),
        ),
        border: const Border(
          top: BorderSide(color: AuthColors.accent, width: 3),
        ),
      ),
      child: Column(
        children: [

          // Onglets
          AuthTabBar(selectedIndex: _selectedTab, onTabChanged: _onTabChanged),

          // Contenu du formulaire
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                // Titre
                Text(
                  'Portail d\'Accès',
                  style: TextStyle(
                    color: AuthColors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Georgia',
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Veuillez saisir vos identifiants académiques\npour continuer.',
                  style: TextStyle(
                    color: AuthColors.white70,
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),

                // Ligne pointillée
                _buildDottedLine(),
                SizedBox(height: 24.h),

                // Champ identifiant
                AuthTextField(
                  label: 'IDENTIFIANT',
                  hint: 'Matricule ou Email',
                  prefixIcon: Icons.badge_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.h),

                // Champ mot de passe
                AuthTextField(
                  label: 'MOT DE PASSE',
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  controller: _passwordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 14.w),
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AuthColors.white40,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Mot de passe oublié
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigation mot de passe oublié
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(
                        color: AuthColors.accent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Bouton ACCÉDER AU PORTAIL
                AuthPrimaryButton(
                  label: 'ACCÉDER AU PORTAIL',
                  isLoading: isLoading,
                  onPressed: _onLogin,
                ),
                SizedBox(height: 28.h),

                // Séparateur ACCÈS ALTERNATIF
                const AuthDivider(label: 'ACCÈS ALTERNATIF'),
                SizedBox(height: 20.h),

                // Boutons sociaux
                Row(
                  children: [
                    AuthSocialButton(
                      label: 'Google',
                      textIcon: "G",
                      onPressed: () {
                        // TODO: Google sign in
                      },
                    ),
                    SizedBox(width: 14.w),
                    AuthSocialButton(
                      label: 'Apple ID',
                      icon: Icons.apple,
                      onPressed: () {
                        // TODO: Apple sign in
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),

          // Bordure gradient en bas
          Container(
            height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AuthColors.accent,
                  AuthColors.buttonGreen,
                  AuthColors.accent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Ligne pointillée décorative
  Widget _buildDottedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 5.0;
        const dashSpace = 4.0;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AuthColors.fieldBorder),
              ),
            );
          }),
        );
      },
    );
  }
}
