import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParcoursTimeline extends StatelessWidget {
  const ParcoursTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF14241F),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mon Parcours',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10E8A4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '60%',
                    style: TextStyle(
                      color: const Color(0xFF10E8A4),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25.h),
          _buildStep(
            title: 'Création du Profil',
            subtitle: 'Terminé le 12 Oct',
            status: _StepStatus.completed,
            isLast: false,
          ),
          _buildStep(
            title: 'Analyse IA',
            subtitle: 'En cours • Analyse des intérêts',
            status: _StepStatus.active,
            isLast: false,
            action: _buildActionBtn(),
          ),
          _buildStep(
            title: 'Sélection d\'Université',
            subtitle: 'Verrouillé',
            status: _StepStatus.locked,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String title,
    required String subtitle,
    required _StepStatus status,
    required bool isLast,
    Widget? action,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLine(status, isLast),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: status == _StepStatus.locked
                        ? Colors.white38
                        : Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (status == _StepStatus.locked)
                      Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 12.w,
                          color: Colors.white38,
                        ),
                      ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: status == _StepStatus.active
                            ? const Color(0xFFD4B46E)
                            : Colors.white38,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                if (action != null) ...[SizedBox(height: 12.h), action],
                if (!isLast) SizedBox(height: 25.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(_StepStatus status, bool isLast) {
    return Column(
      children: [
        _buildNode(status),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2.w,
              color: status == _StepStatus.completed
                  ? const Color(0xFF0E8C6A)
                  : Colors.white10,
            ),
          ),
      ],
    );
  }

  Widget _buildNode(_StepStatus status) {
    switch (status) {
      case _StepStatus.completed:
        return Container(
          width: 24.w,
          height: 24.w,
          decoration: const BoxDecoration(
            color: Color(0xFF0E8C6A),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 14.w, color: Colors.white),
        );
      case _StepStatus.active:
        return Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: const Color(0xFFD4B46E).withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD4B46E), width: 2.w),
          ),
          child: Center(
            child: Icon(
              Icons.psychology_outlined,
              size: 14.w,
              color: const Color(0xFFD4B46E),
            ),
          ),
        );
      case _StepStatus.locked:
        return Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: Colors.white10,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.school_outlined, size: 14.w, color: Colors.white24),
        );
    }
  }

  Widget _buildActionBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Continuer l\'Analyse',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.arrow_forward_rounded,
            size: 14.w,
            color: const Color(0xFFD4B46E),
          ),
        ],
      ),
    );
  }
}

enum _StepStatus { completed, active, locked }
