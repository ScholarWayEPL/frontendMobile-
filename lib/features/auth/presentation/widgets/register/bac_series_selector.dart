import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_widgets.dart';

/// Modèle pour une série du baccalauréat
class BacSeries {
  final String code;
  final String label;
  final String description;

  const BacSeries({
    required this.code,
    required this.label,
    required this.description,
  });
}

/// Constantes des séries disponibles
const kBacSeriesList = [
  BacSeries(code: 'S', label: 'Scientifique (S)', description: 'Maths, Phys, SVT'),
  BacSeries(code: 'L', label: 'Littéraire (L)', description: 'Langues, Philo'),
  BacSeries(code: 'ES', label: 'Économique (ES)', description: 'Sc. Sociales'),
  BacSeries(code: 'T', label: 'Technique', description: 'Ingénierie, Info'),
];

/// Grille de sélection de la série du baccalauréat
class BacSeriesSelector extends StatelessWidget {
  final String? selectedCode;
  final ValueChanged<String> onSelected;

  const BacSeriesSelector({
    super.key,
    this.selectedCode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: kBacSeriesList.map((series) {
        final isSelected = selectedCode == series.code;
        return GestureDetector(
          onTap: () => onSelected(series.code),
          child: Container(
            width: (MediaQuery.of(context).size.width - 40.w - 50.w) / 2,
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: isSelected ? AuthColors.selectedTint : AuthColors.fieldBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? AuthColors.accent : AuthColors.fieldBorder,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  series.label,
                  style: TextStyle(
                    color: isSelected ? AuthColors.accent : AuthColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  series.description,
                  style: TextStyle(
                    color: AuthColors.white40,
                    fontSize: 11.sp,
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
