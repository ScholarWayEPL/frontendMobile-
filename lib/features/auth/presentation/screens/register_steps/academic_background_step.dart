import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/register/shared_widgets.dart';
import '../../widgets/register/bac_series_selector.dart';
import '../../widgets/register/subject_grade_item.dart';
import '../../widgets/register/file_upload_card.dart';

class AcademicBackgroundStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onSave;

  const AcademicBackgroundStep({
    super.key,
    required this.onNext,
    this.onSave,
  });

  @override
  State<AcademicBackgroundStep> createState() => _AcademicBackgroundStepState();
}

class _AcademicBackgroundStepState extends State<AcademicBackgroundStep> {
  final _schoolController = TextEditingController();
  String? _selectedBacSeries;
  String? _uploadedFileName;

  final List<SubjectGrade> _subjects = [
    const SubjectGrade(
      initial: 'M',
      name: 'Mathématiques',
      grade: 15,
      barColor: AuthColors.accent,
    ),
    const SubjectGrade(
      initial: 'P',
      name: 'Physique',
      grade: 12,
      barColor: AuthColors.barGold,
    ),
  ];

  @override
  void dispose() {
    _schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Contenu scrollable
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const StepTitle(
                  title: 'Parcours',
                  highlight: 'Académique',
                  description:
                      'Construisons votre profil scolaire. Nous utiliserons ces données pour personnaliser vos recommandations universitaires.',
                ),
                SizedBox(height: 28.h),

                // High School
                Stack(
                  children: [
                    SectionCard(
                      label: 'LYCÉE D\'ORIGINE',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchField(
                            hint: 'Rechercher votre établissement...',
                            controller: _schoolController,
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              _LocationTag(label: 'Lagos'),
                              SizedBox(width: 10.w),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Handle école introuvable
                                },
                                child: Text(
                                  'École introuvable ?',
                                  style: TextStyle(
                                    color: AuthColors.white40,
                                    fontSize: 12.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AuthColors.white40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 12.h,
                      right: 14.w,
                      child: Icon(
                        Icons.school_outlined,
                        color: AuthColors.white20,
                        size: 44.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Série du baccalauréat
                SectionCard(
                  label: 'SÉRIE DU BACCALAURÉAT',
                  child: BacSeriesSelector(
                    selectedCode: _selectedBacSeries,
                    onSelected: (code) {
                      setState(() => _selectedBacSeries = code);
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                // Notes des matières clés
                SectionCard(
                  label: 'NOTES DES MATIÈRES CLÉS',
                  trailing: GestureDetector(
                    onTap: () {
                      // TODO: Add subject
                    },
                    child: Icon(
                      Icons.add,
                      color: AuthColors.white70,
                      size: 22.sp,
                    ),
                  ),
                  child: Column(
                    children: _subjects
                        .map((s) => SubjectGradeItem(subject: s))
                        .toList(),
                  ),
                ),
                SizedBox(height: 16.h),

                // Upload relevé de notes
                FileUploadCard(
                  fileName: _uploadedFileName,
                  onTap: () {
                    // TODO: File picker
                    setState(() {
                      _uploadedFileName = 'releve_notes.pdf';
                    });
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),

        // Barre de boutons
        StepBottomBar(
          secondaryLabel: 'Enregistrer',
          primaryLabel: 'Étape Suivante',
          onSecondary: widget.onSave,
          onPrimary: widget.onNext,
        ),
      ],
    );
  }
}

/// Tag de localisation
class _LocationTag extends StatelessWidget {
  final String label;

  const _LocationTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
      color: AuthColors.selectedTint,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: AuthColors.accent.withAlpha(80), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, color: AuthColors.accent, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: AuthColors.accent,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
