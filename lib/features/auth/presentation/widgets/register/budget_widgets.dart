import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Carte de saisie du budget mensuel
class BudgetInputCard extends StatelessWidget {
  final TextEditingController controller;
  final String currency;

  const BudgetInputCard({
    super.key,
    required this.controller,
    this.currency = 'XOF',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Champ de saisie montant
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              currency,
              style: TextStyle(
                color: AuthColors.accent,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Georgia',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Stack(
                children: [
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: AuthColors.white,
                      fontSize: 36.sp,
                      fontFamily: 'Georgia',
                    ),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: AuthColors.white40,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Georgia',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.account_balance_outlined,
                      color: AuthColors.white70.withAlpha(10),
                      size: 50.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(height: 1, color: AuthColors.fieldBorder),
        SizedBox(height: 12.h),
        // Min + label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MIN : 45K',
              style: TextStyle(
                color: AuthColors.white40,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'ZONE DE CONFORT',
              style: TextStyle(
                color: AuthColors.accent,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Ligne de ventilation des coûts
class CostBreakdownItem extends StatelessWidget {
  final String label;
  final String amount;
  final Color barColor;
  final double progress;

  const CostBreakdownItem({
    super.key,
    required this.label,
    required this.amount,
    required this.barColor,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(color: AuthColors.white70, fontSize: 13.sp),
              ),
              Text(
                amount,
                style: TextStyle(
                  color: AuthColors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(2.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4.h,
              backgroundColor: AuthColors.fieldBorder,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }
}

/// Carte de projection des coûts
class ProjectionBreakdownCard extends StatelessWidget {
  final String totalLabel;
  final String totalAmount;
  final String totalCurrency;
  final List<CostBreakdownItem> items;

  const ProjectionBreakdownCard({
    super.key,
    required this.totalLabel,
    required this.totalAmount,
    required this.totalCurrency,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête avec icône
        Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AuthColors.fieldBackground,
                border: Border.all(color: AuthColors.fieldBorder, width: 1),
              ),
              child: Icon(
                Icons.currency_exchange,
                color: AuthColors.accent,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'DÉTAIL DE LA PROJECTION',
              style: TextStyle(
                color: AuthColors.gold,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              totalLabel,
              style: TextStyle(
                color: AuthColors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  totalAmount,
                  style: TextStyle(
                    color: AuthColors.accent,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  totalCurrency,
                  style: TextStyle(color: AuthColors.white40, fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Container(height: 1, color: AuthColors.fieldBorder),
        SizedBox(height: 14.h),

        // Lignes de ventilation
        ...items,
      ],
    );
  }
}
