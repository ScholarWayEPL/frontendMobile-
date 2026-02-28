import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';
import 'auth_text_field.dart';
import 'auth_primary_button.dart';
import 'auth_divider.dart';
import 'auth_social_button.dart';

/// Vue du formulaire de connexion
class LoginFormView extends StatefulWidget {
  final bool isLoading;
  final Function(String email, String password) onLogin;
  final VoidCallback onSocialGoogle;
  final VoidCallback onSocialApple;

  const LoginFormView({
    super.key,
    required this.isLoading,
    required this.onLogin,
    required this.onSocialGoogle,
    required this.onSocialApple,
  });

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Portail d\'Accès', style: _titleStyle()),
          SizedBox(height: 6.h),
          Text(
            'Veuillez saisir vos identifiants académiques pour continuer.',
            style: _subStyle(),
          ),
          SizedBox(height: 20.h),
          _buildDottedLine(),
          SizedBox(height: 24.h),
          AuthTextField(
            label: 'IDENTIFIANT',
            hint: 'E-mail ou Matricule',
            prefixIcon: Icons.badge_outlined,
            controller: _emailController,
          ),
          SizedBox(height: 20.h),
          AuthTextField(
            label: 'MOT DE PASSE',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            controller: _passwordController,
            suffixIcon: _buildVisibilityIcon(),
          ),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implémenter la récupération de mot de passe
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
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AuthColors.accent,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          AuthPrimaryButton(
            label: 'ACCÉDER AU PORTAIL',
            isLoading: widget.isLoading,
            onPressed: () => widget.onLogin(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            ),
          ),
          SizedBox(height: 28.h),
          const AuthDivider(label: 'ACCÈS ALTERNATIF'),
          SizedBox(height: 20.h),
          _buildSocialRows(),
        ],
      ),
    );
  }

  TextStyle _titleStyle() => TextStyle(
    color: AuthColors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Georgia',
  );

  TextStyle _subStyle() =>
      TextStyle(color: AuthColors.white70, fontSize: 13.sp, height: 1.5);

  Widget _buildVisibilityIcon() {
    return GestureDetector(
      onTap: () => setState(() => _obscurePassword = !_obscurePassword),
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
    );
  }

  Widget _buildSocialRows() {
    return Row(
      children: [
        Expanded(
          child: AuthSocialButton(
            label: 'Google',
            textIcon: "G",
            onPressed: widget.onSocialGoogle,
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: AuthSocialButton(
            label: 'Apple ID',
            icon: Icons.apple,
            onPressed: widget.onSocialApple,
          ),
        ),
      ],
    );
  }

  Widget _buildDottedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / 9).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
            (_) =>
                Container(width: 5, height: 1, color: AuthColors.fieldBorder),
          ),
        );
      },
    );
  }
}
