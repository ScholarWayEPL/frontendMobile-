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

/// Constantes des séries disponibles au Togo
const kBacSeriesList = [
  BacSeries(code: 'D', label: 'Scientifique(S)', description: 'Maths, Phys, SVT'),
  BacSeries(code: 'C', label: 'Littéraire (L)', description: 'Langues, Philo'),
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(kBacSeriesList[0].code),
                child: _buildCard(kBacSeriesList[0]),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(kBacSeriesList[1].code),
                child: _buildCard(kBacSeriesList[1]),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(kBacSeriesList[2].code),
                child: _buildCard(kBacSeriesList[2]),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(kBacSeriesList[3].code),
                child: _buildCard(kBacSeriesList[3]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(BacSeries series) {
    final isSelected = selectedCode == series.code;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: isSelected ? AuthColors.selectedTint : AuthColors.fieldBackground,
        borderRadius: BorderRadius.circular(10.r),
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
              color: AuthColors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 3.h),
          Text(
            series.description,
            style: TextStyle(
              color: AuthColors.white40,
              fontSize: 10.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
