import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/register/shared_widgets.dart';

/// Étape 4 : Révision et soumission du profil
class ReviewStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const ReviewStep({
    super.key,
    required this.onNext,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const StepTitle(
                  title: 'Review &',
                  highlight: 'Submit',
                  description:
                      'Review your information before submitting your profile. Make sure everything is accurate.',
                ),
                SizedBox(height: 28.h),

                SectionCard(
                  label: 'PROFILE SUMMARY',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your profile information will appear here for review.',
                        style: TextStyle(
                          color: AuthColors.white50,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),

        StepBottomBar(
          secondaryLabel: 'Back',
          primaryLabel: 'Submit',
          onSecondary: onBack,
          onPrimary: onNext,
        ),
      ],
    );
  }
}
