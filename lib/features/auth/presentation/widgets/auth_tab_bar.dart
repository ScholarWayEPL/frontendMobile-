import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

/// Barre d'onglets Connexion / Inscription
class AuthTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const AuthTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AuthColors.fieldBackground.withAlpha(100),
      child: Row(
        children: [_buildTab('Connexion', 0), _buildTab('Inscription', 1)],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? const Color.fromARGB(255, 52, 211, 153)
                      : AuthColors.white40,
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 3.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 52, 211, 153)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
