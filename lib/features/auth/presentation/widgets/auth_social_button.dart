import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

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
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        side: BorderSide(color: AuthColors.fieldBorder, width: 1.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        minimumSize: Size(0, 50.h), // Assure une hauteur minimale cohérente
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          SizedBox(width: 8.w),
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
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return Icon(icon, size: 20.sp, color: AuthColors.white70);
    } else if (textIcon != null) {
      return Text(
        textIcon!,
        style: TextStyle(
          color: AuthColors.white70,
          fontSize: 18.sp, // Légère réduction pour l'équilibre visuel
          fontWeight: FontWeight.w800,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
