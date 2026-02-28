import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/state/auth_state.dart';
import 'package:scholarway/features/matching/presentation/screens/recommendations_screen.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/home_header.dart';
import '../widgets/home_greeting.dart';
import '../widgets/parcours_timeline.dart';
import '../widgets/best_match_card.dart';
import '../widgets/tools_grid.dart';
import '../widgets/home_bottom_nav.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState is AuthAuthenticated ? authState.user : null;

    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex == 1 ? 2 : (_currentIndex == 3 ? 1 : 0),
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    const HomeHeader(),
                    SizedBox(height: 25.h),
                    HomeGreeting(
                      nom: user?.nom ?? '',
                      prenom: user?.prenom ?? '',
                    ),
                    SizedBox(height: 30.h),
                    const ParcoursTimeline(),
                    SizedBox(height: 35.h),
                    const BestMatchSection(),
                    SizedBox(height: 35.h),
                    const ToolsSection(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
            const ProfileScreen(),
            const RecommendationsScreen(),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 60.w,
      height: 60.w,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD4B46E),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.chat_bubble_outline_rounded,
        color: Colors.black,
        size: 30.w,
      ),
    );
  }
}
