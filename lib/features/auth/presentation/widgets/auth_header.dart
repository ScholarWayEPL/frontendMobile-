import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

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
                  'Orienter la future élite académique\nde l\'Afrique de l\'Afrique de l\'Ouest.',
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
