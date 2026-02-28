import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';

class AlternativeRecommendationCard extends StatelessWidget {
  final String title;
  final String university;
  final String match;
  final String rank;
  final String location;
  final String tag;
  final String imageUrl;

  const AlternativeRecommendationCard({
    super.key,
    required this.title,
    required this.university,
    required this.match,
    required this.rank,
    required this.location,
    required this.tag,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AuthColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          // Small Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 5.h,
                  left: 5.w,
                  child: Text(
                    location,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(blurRadius: 4, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$match Match',
                      style: TextStyle(
                        color: const Color(0xFF10E8A4),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      rank,
                      style: TextStyle(
                        color: AuthColors.white40,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  university,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AuthColors.white40, fontSize: 12.sp),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: AuthColors.white70,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          // Actions
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.more_vert, color: AuthColors.white40, size: 20.w),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: const Color(0xFF10E8A4),
                  size: 20.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
