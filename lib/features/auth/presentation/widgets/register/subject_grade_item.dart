import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Modèle pour une matière avec note
class SubjectGrade {
  final String initial;
  final String name;
  final double grade;
  final double maxGrade;
  final Color barColor;

  const SubjectGrade({
    required this.initial,
    required this.name,
    required this.grade,
    this.maxGrade = 20,
    this.barColor = AuthColors.accent,
  });
}

/// Item affichant une note avec barre de progression
class SubjectGradeItem extends StatelessWidget {
  final SubjectGrade subject;
  final VoidCallback? onTap;

  const SubjectGradeItem({
    super.key,
    required this.subject,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = subject.grade / subject.maxGrade;

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          // Initiale
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AuthColors.fieldBackground,
              border: Border.all(color: AuthColors.fieldBorder, width: 1),
            ),
            child: Center(
              child: Text(
                subject.initial,
                style: TextStyle(
                  color: AuthColors.white70,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Nom + barre
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: TextStyle(
                    color: AuthColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4.h,
                    backgroundColor: AuthColors.fieldBorder,
                    valueColor: AlwaysStoppedAnimation<Color>(subject.barColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Note
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AuthColors.fieldBackground,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AuthColors.fieldBorder, width: 1),
                ),
                child: Text(
                  subject.grade.toInt().toString(),
                  style: TextStyle(
                    color: AuthColors.accent,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '/ ${subject.maxGrade.toInt()}',
                style: TextStyle(
                  color: AuthColors.white40,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
