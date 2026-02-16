import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/register/shared_widgets.dart';
import '../../widgets/register/career_widgets.dart';

class CareerObjectivesStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const CareerObjectivesStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<CareerObjectivesStep> createState() => _CareerObjectivesStepState();
}

class _CareerObjectivesStepState extends State<CareerObjectivesStep> {
  final _professionController = TextEditingController();
  final Set<String> _selectedDomains = {'sciences'};
  final Set<String> _selectedMotivations = {'Innovation'};

  static const _motivations = [
    'Innovation',
    'Stabilité',
    'Impact Social',
    'Salaire Élevé',
  ];

  @override
  void dispose() {
    _professionController.dispose();
    super.dispose();
  }

  void _toggleDomain(String id) {
    setState(() {
      if (_selectedDomains.contains(id)) {
        _selectedDomains.remove(id);
      } else if (_selectedDomains.length < 3) {
        _selectedDomains.add(id);
      }
    });
  }

  void _toggleMotivation(String m) {
    setState(() {
      if (_selectedMotivations.contains(m)) {
        _selectedMotivations.remove(m);
      } else {
        _selectedMotivations.add(m);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Hero image en haut
                Container(
                  width: double.infinity,
                  height: 120.h,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/onboarding0.png'),
                      fit: BoxFit.cover,
                      opacity: 0.3,
                    ),
                    color: AuthColors.background,
                  ),
                ),

                // Carte formulaire
                Transform.translate(
                  offset: Offset(0, -30.h),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AuthColors.cardBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border(
                        left: BorderSide(
                          color: AuthColors.gold,
                          width: 3,
                        ),
                        top: BorderSide(
                          color: AuthColors.gold.withAlpha(40),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: AuthColors.gold.withAlpha(40),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: AuthColors.gold.withAlpha(40),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Objectifs de Carrière',
                          style: TextStyle(
                            color: AuthColors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Aidez notre IA à comprendre vos aspirations pour vous proposer des recommandations sur mesure.',
                          style: TextStyle(
                            color: AuthColors.white70,
                            fontSize: 13.sp,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Profession ciblée
                        Text(
                          'PROFESSION CIBLÉE',
                          style: TextStyle(
                            color: AuthColors.gold,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SearchField(
                          hint: 'ex. Ingénieur Civil, Neurologue..',
                          controller: _professionController,
                        ),
                        SizedBox(height: 24.h),

                        // Domaines d'intérêt
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DOMAINES D\'INTÉRÊT',
                              style: TextStyle(
                                color: AuthColors.gold,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.5,
                              ),
                            ),
                            Text(
                              'Sélectionnez jusqu\'à 3',
                              style: TextStyle(
                                color: AuthColors.white40,
                                fontSize: 11.sp,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        InterestDomainGrid(
                          selectedIds: _selectedDomains,
                          onToggle: _toggleDomain,
                        ),
                        SizedBox(height: 24.h),

                        // Motivations clés
                        Text(
                          'MOTIVATIONS CLÉS',
                          style: TextStyle(
                            color: AuthColors.gold,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        MotivationChips(
                          motivations: _motivations,
                          selected: _selectedMotivations,
                          onToggle: _toggleMotivation,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom bar
        StepBottomBar(
          secondaryLabel: 'Retour',
          primaryLabel: 'CONTINUER',
          onSecondary: widget.onBack,
          onPrimary: widget.onNext,
        ),
      ],
    );
  }
}
