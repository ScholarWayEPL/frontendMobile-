import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';
import 'auth_header.dart';

/// Section hero avec l'image de fond, le logo et le slogan
class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}
