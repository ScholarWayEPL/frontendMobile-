import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Utilitaire global pour afficher des notifications (Snackbars) uniformes dans toute l'application.
class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = true,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        // On utilise des couleurs semi-transparentes pour un look premium
        backgroundColor: isError
            ? const Color(0xFFEF4444).withAlpha(220) // Rouge/Erreur
            : const Color(0xFF10B981).withAlpha(220), // Vert/Succès
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 30.h,
          top: 15.w,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
