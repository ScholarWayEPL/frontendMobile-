import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Indicateur de progression par étapes
class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        if (isActive) {
          return Container(
            width: 28.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: AuthColors.accent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          );
        }
        return Container(
          width: 8.w,
          height: 8.w,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AuthColors.fieldBorder,
          ),
        );
      }),
    );
  }
}

/// AppBar personnalisée pour les étapes d'inscription
class StepAppBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  const StepAppBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onBack,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton retour
                _CircleButton(
                  icon: Icons.arrow_back,
                  onPressed: onBack ?? () => context.pop(),
                ),
                // Label étape
                Text(
                  'STEP $currentStep OF $totalSteps',
                  style: TextStyle(
                    color: AuthColors.gold,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                // Bouton aide
                _CircleButton(icon: Icons.help_outline, onPressed: onHelp),
              ],
            ),
            SizedBox(height: 10.h),
            StepIndicator(currentStep: currentStep, totalSteps: totalSteps),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData? icon;
  final String? letter;
  final VoidCallback? onPressed;

  const _CircleButton({this.icon, this.letter, this.onPressed})
    : assert(
        icon != null || letter != null,
        'Either icon or letter must be provided',
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AuthColors.fieldBackground,
          border: Border.all(color: AuthColors.fieldBorder, width: 1),
        ),
        child: icon != null
            ? Icon(icon, color: AuthColors.white70, size: 20.sp)
            : Center(
                child: Text(
                  letter!,
                  style: TextStyle(
                    color: AuthColors.white70,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

/// En-tête de section avec titre et description
class StepTitle extends StatelessWidget {
  final String title;
  final String highlight;
  final String description;

  const StepTitle({
    super.key,
    required this.title,
    required this.highlight,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AuthColors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Georgia',
            height: 1.2,
          ),
        ),
        Text(
          highlight,
          style: TextStyle(
            color: AuthColors.barGold,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            fontFamily: 'Georgia',
            height: 1.2,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          style: TextStyle(
            color: AuthColors.white70,
            fontSize: 13.5.sp,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

/// Carte sombre conteneur de section
class SectionCard extends StatelessWidget {
  final String? label;
  final Widget? trailing;
  final Widget child;

  const SectionCard({
    super.key,
    this.label,
    this.trailing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 35, 38),
        borderRadius: BorderRadius.circular(10.r),
        // Ombre subtile pour faire ressortir la carte
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                      color: AuthColors.gold,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          child,
        ],
      ),
    );
  }
}

/// Champ de recherche partagé
class SearchField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AuthColors.fieldBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AuthColors.fieldBorder, width: 1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: AuthColors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AuthColors.white40, fontSize: 14.sp),
          prefixIcon: Icon(
            Icons.search,
            color: AuthColors.white40,
            size: 22.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}

/// Barre de boutons en bas (Enregistrer / Étape Suivante)
class StepBottomBar extends StatelessWidget {
  final String? secondaryLabel;
  final String primaryLabel;
  final VoidCallback? onSecondary;
  final VoidCallback? onPrimary;
  final bool isLoading;

  const StepBottomBar({
    super.key,
    this.secondaryLabel,
    required this.primaryLabel,
    this.onSecondary,
    this.onPrimary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AuthColors.background,
        border: Border(
          top: BorderSide(color: AuthColors.fieldBorder, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (secondaryLabel != null) ...[
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: onSecondary,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(color: AuthColors.fieldBorder, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    secondaryLabel!,
                    style: TextStyle(
                      color: AuthColors.white70,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: isLoading ? null : onPrimary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuthColors.buttonGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            primaryLabel,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward, size: 20.sp),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
