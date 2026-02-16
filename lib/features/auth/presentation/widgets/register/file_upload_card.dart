import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Carte d'upload de fichier (relevé de notes)
class FileUploadCard extends StatelessWidget {
  final String? fileName;
  final VoidCallback? onTap;

  const FileUploadCard({
    super.key,
    this.fileName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AuthColors.cardBackground,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: hasFile ? AuthColors.accent : AuthColors.fieldBorder,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasFile
                    ? AuthColors.selectedTint
                    : AuthColors.fieldBackground,
              ),
              child: Icon(
                hasFile ? Icons.check : Icons.upload,
                color: hasFile ? AuthColors.accent : AuthColors.white70,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              hasFile ? fileName! : 'Ajouter le Relevé de Notes',
              style: TextStyle(
                color: AuthColors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              hasFile ? 'Fichier sélectionné' : 'PDF ou JPG (Max 5Mo)',
              style: TextStyle(
                color: AuthColors.white40,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
