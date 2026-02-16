import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Couleurs extraites rigoureusement des maquettes
class AuthColors {
  // --- Fonds ---
  static const Color background = Color(
    0xFF091A16,
  ); // Fond de page principal (quasi-noir verdâtre)
  static const Color cardBackground = Color(
    0xFF0F2421,
  ); // Fond des cartes / formulaires
  static const Color fieldBackground = Color.fromARGB(
    255,
    11,
    20,
    22,
  ); // Fond des champs de saisie
  static const Color fieldBorder = Color(
    0xFF1A3832,
  ); // Bordure subtile des champs et cartes

  // --- Accents ---
  static const Color accent = Color.fromARGB(
    255,
    6,
    78,
    59,
  ); // Vert émeraude vif (liens, onglet actif, textes accentués)
  static const Color buttonGreen = Color(
    0xFF0E8C6A,
  ); // Teal profond (boutons CTA uniquement)

  // --- Or / Labels ---
  static const Color gold = Color(
    0xFFB8A992,
  ); // Doré (labels de section en majuscules)
  static const Color goldLight = Color(0xFFD4C5A9); // Doré clair

  // --- Blancs ---
  static const Color white = Colors.white;
  static const Color white70 = Color(0xB3FFFFFF); // Texte secondaire
  static const Color white50 = Color(0x80FFFFFF); // Texte tertiaire
  static const Color white40 = Color(
    0x66FFFFFF,
  ); // Texte discret / placeholders
  static const Color white20 = Color(0x33FFFFFF); // Très discret

  // --- Couleurs thématiques ---
  static const Color selectedTint = Color(
    0xFF0D3D2F,
  ); // Fond des éléments sélectionnés
  static const Color barGold = Color(
    0xFFC4A96A,
  ); // Barres de progression dorées
  static const Color barTeal = Color(0xFF3A6B5D); // Barres secondaires
}

/// En-tête "Scholar Way" avec badge "Fondé en 2024"
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge "Fondé en 2024"
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AuthColors.fieldBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.school_outlined,
                color: AuthColors.gold,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Fondé en 2026',
              style: TextStyle(
                color: AuthColors.white70,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        // ScholarWay
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Scholar',
                style: TextStyle(
                  color: AuthColors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Georgia',
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Way',
                style: TextStyle(
                  color: AuthColors.gold,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Georgia',
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        // Slogan avec bordure dorée
        IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 3.w,
                decoration: BoxDecoration(
                  color: AuthColors.gold,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Orienter la future élite académique\nde l\'Afrique de l\'Ouest.',
                  style: TextStyle(
                    color: AuthColors.white70,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Barre d'onglets Connexion / Inscription
class AuthTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const AuthTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AuthColors.fieldBackground.withAlpha(100),
      child: Row(
        children: [_buildTab('Connexion', 0), _buildTab('Inscription', 1)],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? Color.fromARGB(255, 52, 211, 153)
                      : AuthColors.white40,
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 3.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? Color.fromARGB(255, 52, 211, 153)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Champ de saisie personnalisé pour l'auth
class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AuthColors.gold,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: AuthColors.fieldBackground,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AuthColors.fieldBorder, width: 1),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(color: AuthColors.white, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AuthColors.white40, fontSize: 15.sp),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.w, right: 10.w),
                child: Icon(prefixIcon, color: AuthColors.white40, size: 22.sp),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 46.w,
                minHeight: 22.h,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Bouton principal d'authentification
class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuthColors.buttonGreen,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AuthColors.buttonGreen.withAlpha(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Icon(Icons.arrow_forward, size: 20.sp),
                ],
              ),
      ),
    );
  }
}

/// Bouton d'accès alternatif (Google, Apple)
class AuthSocialButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? textIcon;
  final VoidCallback? onPressed;

  const AuthSocialButton({
    super.key,
    required this.label,
    this.icon,
    this.textIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, size: 20.sp, color: AuthColors.white70)
            : null,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AuthColors.white70,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          side: BorderSide(color: AuthColors.fieldBorder, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}

/// Séparateur "ACCÈS ALTERNATIF"
class AuthDivider extends StatelessWidget {
  final String label;

  const AuthDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AuthColors.fieldBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            label,
            style: TextStyle(
              color: AuthColors.white40,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AuthColors.fieldBorder)),
      ],
    );
  }
}

/// Footer de l'écran d'auth
class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confidentialité',
              style: TextStyle(color: AuthColors.white40, fontSize: 12.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                '•',
                style: TextStyle(color: AuthColors.white40, fontSize: 12.sp),
              ),
            ),
            Text(
              'Aide & Support',
              style: TextStyle(color: AuthColors.white40, fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'SYSTÈMES ACADÉMIQUES SCHOLARWAY © 2024',
          style: TextStyle(
            color: AuthColors.white20,
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
