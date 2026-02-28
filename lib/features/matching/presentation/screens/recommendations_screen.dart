import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';
import '../widgets/recommendations_header.dart';
import '../widgets/recommendation_filter_chips.dart';
import '../widgets/featured_recommendation_card.dart';
import '../widgets/alternative_recommendation_card.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = [
    'Tous les programmes',
    'Bourses',
    'Frais réduits',
    'Alternance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RecommendationsHeader(),
              SizedBox(height: 20.h),
              RecommendationFilterChips(
                selectedIndex: _selectedFilterIndex,
                filters: _filters,
                onSelected: (index) {
                  setState(() => _selectedFilterIndex = index);
                },
              ),
              SizedBox(height: 30.h),
              _buildFeaturedSection(),
              SizedBox(height: 35.h),
              _buildAlternativesSection(),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meilleure Recommandation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.military_tech_rounded,
                    color: const Color(0xFFD4B46E),
                    size: 16.w,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Meilleur choix',
                    style: TextStyle(
                      color: const Color(0xFFD4B46E),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          const FeaturedRecommendationCard(),
        ],
      ),
    );
  }

  Widget _buildAlternativesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Options Alternatives',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          const AlternativeRecommendationCard(
            title: 'Ingénierie des...',
            university: 'University of Ghana',
            match: '92%',
            rank: 'Rang #2',
            location: 'Accra, GH',
            tag: 'Bourse disponible',
            imageUrl:
                'https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000',
          ),
          const AlternativeRecommendationCard(
            title: 'Économie & Dév.',
            university: 'Covenant University',
            match: '88%',
            rank: 'Rang #3',
            location: 'Ota, NG',
            tag: 'Forte Employabilité',
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDlf6VvzbJZhI5PTuI1iMEIlCr7F4FqK8BSIV0AsqgFwn2dVNzoMejg1YeZI6zyENx54g0zJUtaaO9k_vV6ojswDUsyU-pGLgzlsOiWbanUPkLBSjJlOXQHUKq3RDGPe-nF76n3StWo4tgGpiY_3TsTQJD4kYOTGvTxGlWXLtTNg3Tgl66K9DDhOPyXCm0wydRKYkXg0DdtU1BApW3syCmGkoeadHSXTWyhCv1xLzsx5ifTd9VHaQcbghiaoB07-OtSeENsfAPus4X6',
          ),
          const AlternativeRecommendationCard(
            title: 'S.I.G.',
            university: 'Ashesi University',
            match: '85%',
            rank: 'Rang #4',
            location: 'Berekuso, GH',
            tag: 'Arts Libéraux',
            imageUrl:
                'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?q=80&w=1000',
          ),
        ],
      ),
    );
  }
}
