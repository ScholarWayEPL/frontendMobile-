import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingFooter extends StatelessWidget {
  final VoidCallback onStartTap;

  const OnboardingFooter({super.key, required this.onStartTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.h),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () => context.push('/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10E8A4),
                foregroundColor: const Color(0xFF0D3D35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Commencer l\'Aventure',
                    style: TextStyle(
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward, size: 17.sp),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'En continuant, vous acceptez nos Conditions & Politique de\nConfidentialité.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFB8A992).withOpacity(0.5),
              fontSize: 10.sp,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
