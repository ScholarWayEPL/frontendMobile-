import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

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
          constraints: BoxConstraints(minHeight: 56.h),
          decoration: BoxDecoration(
            color: AuthColors.fieldBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AuthColors.fieldBorder, width: 1.w),
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
