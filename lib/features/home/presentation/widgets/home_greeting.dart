import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';

class HomeGreeting extends StatelessWidget {
  final String nom;
  final String prenom;
  const HomeGreeting({super.key, required this.nom, required this.prenom});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bonsoir,',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$prenom $nom',
          style: TextStyle(
            color: const Color(0xFFD4B46E),
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Votre avenir se dessine. Poursuivez votre\nparcours d\'orientation.',
          style: TextStyle(
            color: AuthColors.white70,
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
