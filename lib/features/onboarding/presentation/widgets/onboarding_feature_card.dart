import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/onboarding_feature.dart';
import '../../../auth/presentation/widgets/auth_widgets.dart';

class OnboardingFeatureCard extends StatelessWidget {
  final OnboardingFeature feature;

  const OnboardingFeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            width: double.infinity,
            padding: EdgeInsets.all(24.h),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 42, 34),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _getIconData(feature.icon),
                      color: const Color(0xFF10E8A4),
                      size: 40.h,
                    ),
                    const Spacer(),
                    Text(
                      feature.number,
                      style: TextStyle(
                        color: const Color(0xFFB8A992).withOpacity(0.25),
                        fontSize: 60.sp,
                        fontWeight: FontWeight.w900,
                        height: 0.8,
                        letterSpacing: -2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  feature.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  feature.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16.sp,
                    height: 1.55,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (feature.imageUrl != null && feature.imageUrl!.isNotEmpty) ...[
            SizedBox(height: 22.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  height: 250.h,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: const Color(0xFF2A3A35),
                  child: Stack(
                    children: [
                      // Image en noir et blanc
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: SizedBox.expand(
                          child: Image.asset(
                            feature.imageUrl!,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholderImage();
                            },
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: const [0.0, 0.5, 1.0],
                            colors: [
                              // Bas très opaque pour fondre avec la page
                              AuthColors.background.withAlpha(255),
                              // Milieu semi-transparent pour laisser transparaître l'image
                              AuthColors.background.withAlpha(200),
                              // Haut transparent
                              AuthColors.background.withAlpha(0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A3A35), Color(0xFF1A2A25)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.groups_outlined,
          size: 64.sp,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'ai':
        return Icons.psychology_outlined;
      case 'finance':
        return Icons.account_balance_outlined;
      case 'school':
        return Icons.school_outlined;
      default:
        return Icons.star_outline;
    }
  }
}
