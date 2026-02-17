import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Carte d'upload de fichier (relevé de notes)
class FileUploadCard extends StatelessWidget {
  final String? fileName;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const FileUploadCard({super.key, this.fileName, this.onTap, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null && fileName!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onRemove,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AuthColors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AuthColors.fieldBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: Offset(0, 2.h),
              blurRadius: 6.r,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered icon circle
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasFile
                    ? AuthColors.selectedTint
                    : AuthColors.fieldBackground,
                border: Border.all(color: AuthColors.fieldBorder, width: 1),
              ),
              child: Center(
                child: hasFile
                    ? Icon(Icons.check, color: AuthColors.accent, size: 26.sp)
                    : Icon(
                        Icons.upload_outlined,
                        color: AuthColors.white70,
                        size: 26.sp,
                      ),
              ),
            ),

            SizedBox(height: 12.h),

            // Title
            Text(
              hasFile ? fileName! : 'Ajouter le Relevé de Notes',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AuthColors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 6.h),

            // Subtitle / hint
            Text(
              hasFile ? 'Fichier sélectionné' : 'PDF ou JPG (Max 5Mo)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AuthColors.white40,
                fontSize: 12.sp,
                height: 1.2,
              ),
            ),
            SizedBox(height: 4.h),
            // Provide a subtle hint about interaction (no internal button)
            Opacity(
              opacity: 0.65,
              child: Text(
                'Appuyez pour ${hasFile ? 'remplacer' : 'ajouter'}',
                textAlign: TextAlign.center,
                style: TextStyle(color: AuthColors.white40, fontSize: 11.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
