import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';
import '../../../auth/presentation/widgets/register/file_upload_card.dart';

class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mes Documents (Togo)',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dossier Scolaire',
                style: TextStyle(
                  color: const Color(0xFFD4B46E),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Veuillez uploader vos relevés de notes originaux pour que nous puissions valider vos demandes d\'admission.',
                style: TextStyle(color: AuthColors.white40, fontSize: 13.sp),
              ),
              SizedBox(height: 30.h),
              _buildDocumentSection('RELEVÉS DE NOTES LYCÉE', [
                'Relevé de notes - Seconde',
                'Relevé de notes - Première',
                'Relevé de notes - Terminale',
              ]),
              SizedBox(height: 30.h),
              _buildDocumentSection('EXAMENS NATIONAUX', [
                'Relevé de notes - BAC 1',
                'Relevé de notes - BAC 2',
              ]),
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuthColors.buttonGreen,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'ENREGISTRER TOUT',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentSection(String title, List<String> docs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AuthColors.white40,
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 15.h),
        ...docs.map(
          (doc) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: FileUploadCard(
              fileName: null, // Initial state
              onTap: () {
                // TODO: Handle individual upload
              },
            ),
          ),
        ),
      ],
    );
  }
}
