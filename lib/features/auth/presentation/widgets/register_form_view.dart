import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';
import 'auth_text_field.dart';
import 'auth_primary_button.dart';
import 'auth_divider.dart';
import 'auth_social_button.dart';

/// Vue du formulaire d'inscription (multi-étapes)
class RegisterFormView extends StatefulWidget {
  final bool isLoading;
  final Function(Map<String, String> data) onRegister;
  final VoidCallback onSocialGoogle;
  final VoidCallback onSocialApple;
  final Function(String? error) onError;

  const RegisterFormView({
    super.key,
    required this.isLoading,
    required this.onRegister,
    required this.onSocialGoogle,
    required this.onSocialApple,
    required this.onError,
  });

  @override
  State<RegisterFormView> createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {
  int _regStep = 1;

  // Step 1 Controllers
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _telephoneController = TextEditingController();

  // Step 2 Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNextStep() {
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final telephone = _telephoneController.text.trim();

    if (nom.isEmpty || prenom.isEmpty || telephone.isEmpty) {
      widget.onError('Veuillez remplir tous les champs');
      return;
    }

    setState(() => _regStep = 2);
  }

  void _onPreviousStep() {
    setState(() => _regStep = 1);
  }

  void _onFinish() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      widget.onError('Veuillez remplir tous les champs');
      return;
    }

    if (password != confirmPassword) {
      widget.onError('Les mots de passe ne correspondent pas');
      return;
    }

    // Pass data back
    widget.onRegister({
      'email': email,
      'motDePasse': password,
      'nom': _nomController.text.trim(),
      'prenom': _prenomController.text.trim(),
      'telephone': _telephoneController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _regStep == 1 ? _buildStep1() : _buildStep2(),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Créer un Compte', style: _titleStyle()),
            Text('1/2', style: _stepStyle()),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          'Rejoignez la communauté ScholarWay et profitez d\'une orientation académique personnalisée.',
          style: _subStyle(),
        ),
        SizedBox(height: 20.h),
        _buildDottedLine(),
        SizedBox(height: 24.h),
        AuthTextField(
          label: 'NOM',
          hint: 'Votre nom',
          prefixIcon: Icons.person_outline,
          controller: _nomController,
        ),
        SizedBox(height: 16.h),
        AuthTextField(
          label: 'PRÉNOM',
          hint: 'Votre prénom',
          prefixIcon: Icons.person_outline,
          controller: _prenomController,
        ),
        SizedBox(height: 16.h),
        AuthTextField(
          label: 'TÉLÉPHONE',
          hint: '+228 XX XX XX XX',
          prefixIcon: Icons.phone_outlined,
          controller: _telephoneController,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 24.h),
        AuthPrimaryButton(label: 'CONTINUER', onPressed: _onNextStep),
        SizedBox(height: 28.h),
        const AuthDivider(label: 'OU S\'INSCRIRE AVEC'),
        SizedBox(height: 20.h),
        _buildSocialRows(),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Identifiants', style: _titleStyle()),
            Text('2/2', style: _stepStyle()),
          ],
        ),
        SizedBox(height: 6.h),
        Text('Sécurisez votre compte personnel.', style: _subStyle()),
        SizedBox(height: 20.h),
        _buildDottedLine(),
        SizedBox(height: 24.h),
        AuthTextField(
          label: 'EMAIL',
          hint: 'exemple@domaine.com',
          prefixIcon: Icons.email_outlined,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16.h),
        AuthTextField(
          label: 'MOT DE PASSE',
          hint: '••••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: _obscurePassword,
          controller: _passwordController,
          suffixIcon: _buildVisibilityIcon(true),
        ),
        SizedBox(height: 16.h),
        AuthTextField(
          label: 'CONFIRMATION',
          hint: '••••••••',
          prefixIcon: Icons.lock_reset_outlined,
          obscureText: _obscureConfirmPassword,
          controller: _confirmPasswordController,
          suffixIcon: _buildVisibilityIcon(false),
        ),
        SizedBox(height: 24.h),
        Center(
          child: Text.rich(
            TextSpan(
              text: 'En continuant, vous acceptez notre ',
              style: TextStyle(color: AuthColors.white40, fontSize: 11.sp),
              children: [
                TextSpan(
                  text: 'Politique de Confidentialité',
                  style: TextStyle(
                    color: AuthColors.accent,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: widget.isLoading ? null : _onPreviousStep,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AuthColors.accent, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AuthColors.accent,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 3,
              child: AuthPrimaryButton(
                label: 'S\'INSCRIRE',
                isLoading: widget.isLoading,
                onPressed: _onFinish,
              ),
            ),
          ],
        ),
      ],
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
  TextStyle _stepStyle() => TextStyle(
    color: AuthColors.accent,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  Widget _buildVisibilityIcon(bool isPassword) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isPassword) {
            _obscurePassword = !_obscurePassword;
          } else {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: Icon(
          (isPassword ? _obscurePassword : _obscureConfirmPassword)
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
