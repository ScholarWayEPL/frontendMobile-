import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

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
          'SYSTÈMES ACADÉMIQUES SCHOLARWAY © 2026',
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
