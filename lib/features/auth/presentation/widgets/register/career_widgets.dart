import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Modèle pour un domaine d'intérêt
class InterestDomain {
  final String id;
  final IconData icon;
  final String label;

  const InterestDomain({
    required this.id,
    required this.icon,
    required this.label,
  });
}

/// Domaines d'intérêt disponibles
const kInterestDomains = [
  InterestDomain(id: 'sciences', icon: Icons.biotech, label: 'Sciences & Tech'),
  InterestDomain(id: 'droit', icon: Icons.gavel, label: 'Droit & Politique'),
  InterestDomain(id: 'commerce', icon: Icons.camera_alt_outlined, label: 'Commerce'),
  InterestDomain(id: 'arts', icon: Icons.palette_outlined, label: 'Arts & Médias'),
];

/// Grille de sélection des domaines d'intérêt
class InterestDomainGrid extends StatelessWidget {
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;
  final int maxSelection;

  const InterestDomainGrid({
    super.key,
    required this.selectedIds,
    required this.onToggle,
    this.maxSelection = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: kInterestDomains.map((domain) {
        final isSelected = selectedIds.contains(domain.id);
        return GestureDetector(
          onTap: () => onToggle(domain.id),
          child: Container(
            width: (MediaQuery.of(context).size.width - 40.w - 50.w) / 2,
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? AuthColors.selectedTint
                  : AuthColors.fieldBackground,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isSelected ? AuthColors.accent : AuthColors.fieldBorder,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      domain.icon,
                      color: isSelected
                          ? AuthColors.accent
                          : AuthColors.white70,
                      size: 24.sp,
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AuthColors.accent,
                        size: 20.sp,
                      )
                    else
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AuthColors.fieldBorder,
                            width: 1.5,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 14.h),
                Text(
                  domain.label,
                  style: TextStyle(
                    color: isSelected ? AuthColors.accent : AuthColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Chips de sélection de motivations
class MotivationChips extends StatelessWidget {
  final List<String> motivations;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const MotivationChips({
    super.key,
    required this.motivations,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: motivations.map((m) {
        final isSelected = selected.contains(m);
        return GestureDetector(
          onTap: () => onToggle(m),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AuthColors.selectedTint
                  : AuthColors.fieldBackground,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AuthColors.accent : AuthColors.fieldBorder,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  m,
                  style: TextStyle(
                    color: isSelected ? AuthColors.accent : AuthColors.white70,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.close,
                    color: AuthColors.accent,
                    size: 14.sp,
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
