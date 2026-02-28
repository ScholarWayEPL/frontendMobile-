import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Outils & Ressources',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: _buildSmallToolCard(
                icon: Icons.grid_view_rounded,
                title: 'Simulateur',
                subtitle: 'Budget & Coûts réels',
                iconColor: const Color(0xFFD4B46E),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: _buildSmallToolCard(
                icon: Icons.help_outline_rounded,
                title: 'Profil Carrière',
                subtitle: 'Match Compétences',
                iconColor: const Color(0xFF10E8A4),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        _buildLargeMentorCard(),
      ],
    );
  }

  Widget _buildSmallToolCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF14241F),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.w),
          ),
          SizedBox(height: 15.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white38, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeMentorCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF14241F),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: const Color(0xFF9489F5),
                  size: 28.w,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parler à un Mentor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Échangez avec des anciens de vos universités cibles.',
                      style: TextStyle(color: Colors.white38, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF9489F5).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF9489F5).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'Nouveau',
                style: TextStyle(
                  color: const Color(0xFF9489F5),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
