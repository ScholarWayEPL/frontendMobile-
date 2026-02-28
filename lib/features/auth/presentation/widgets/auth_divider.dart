import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

/// Séparateur "ACCÈS ALTERNATIF"
class AuthDivider extends StatelessWidget {
  final String label;

  const AuthDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1.w, color: AuthColors.fieldBorder),
        ),
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
        Expanded(
          child: Container(height: 1.w, color: AuthColors.fieldBorder),
        ),
      ],
    );
  }
}
