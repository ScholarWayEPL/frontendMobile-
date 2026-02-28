import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';

class RecommendationFilterChips extends StatelessWidget {
  final int selectedIndex;
  final List<String> filters;
  final Function(int) onSelected;

  const RecommendationFilterChips({
    super.key,
    required this.selectedIndex,
    required this.filters,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.transparent
                    : AuthColors.cardBackground,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0E8C6A)
                      : Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF10E8A4)
                      : AuthColors.white70,
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
