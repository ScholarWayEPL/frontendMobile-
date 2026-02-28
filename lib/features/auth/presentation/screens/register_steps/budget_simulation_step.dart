import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/register/shared_widgets.dart';
import '../../widgets/register/budget_widgets.dart';

class BudgetSimulationStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const BudgetSimulationStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<BudgetSimulationStep> createState() => _BudgetSimulationStepState();
}

class _BudgetSimulationStepState extends State<BudgetSimulationStep> {
  final _budgetController = TextEditingController(text: '125,000');

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

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
                  title: 'Simulation',
                  highlight: 'Budgétaire',
                  description:
                      'Établissons une estimation transparente de votre année académique. Entrez vos paramètres financiers ci‑dessous.',
                ),
                SizedBox(height: 28.h),

                // Capacité Mensuelle
                SectionCard(
                  label: 'CAPACITÉ MENSUELLE',
                  child: BudgetInputCard(controller: _budgetController),
                ),
                SizedBox(height: 16.h),

                // Détail de la projection
                SectionCard(
                  child: ProjectionBreakdownCard(
                    totalLabel: 'Coût Annuel Estimé',
                    totalAmount: '1,85M',
                    totalCurrency: 'XOF',
                    items: [
                      CostBreakdownItem(
                        label: 'Frais de Scolarité',
                        amount: '1,2M',
                        barColor: AuthColors.accent,
                        progress: 0.65,
                      ),
                      CostBreakdownItem(
                        label: 'Logement & Vie',
                        amount: '650k',
                        barColor: AuthColors.barTeal,
                        progress: 0.35,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),

        // Bottom bar
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildBottomBar() {
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
            // Bookmark icon
            GestureDetector(
              onTap: () {
                // TODO: Save bookmark
              },
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AuthColors.fieldBackground,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: AuthColors.fieldBorder,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.bookmark_outline,
                  color: AuthColors.white70,
                  size: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Confirm button
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuthColors.buttonGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'VALIDER LE BUDGET',
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
