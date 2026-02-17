import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_feature.dart';
import '../../domain/entities/partner.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_hero_section.dart';
import '../widgets/onboarding_feature_card.dart';
import '../widgets/onboarding_partners.dart';
import '../widgets/onboarding_footer.dart';
import '../../../auth/presentation/widgets/auth_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<OnboardingFeature> features = [
    OnboardingFeature(
      number: '01',
      icon: 'ai',
      title: 'Clarté par l\'IA',
      description:
          'Des algorithmes sur mesure analysent vos notes, passions et opportunités locales pour recommander le programme idéal.',
      imageUrl: 'assets/images/onboarding1.png',
    ),
    OnboardingFeature(
      number: '02',
      icon: 'finance',
      title: 'Anticipation\nFinancière',
      description:
          'Simulez les frais de scolarité, le coût de la vie et les opportunités de bourses. Planifiez votre avenir sans surprises.',
    ),
  ];

  final List<Partner> partners = [
    Partner(name: 'UNILAG', logoUrl: ''),
    Partner(name: 'ASHESI', logoUrl: ''),
    Partner(name: 'KNUT', logoUrl: ''),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToContent() {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    _scrollController.animateTo(
      screenHeight - statusBarHeight,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _onLoginTap() {
    // TODO: Navigation vers la page de connexion
    Navigator.pushNamed(context, '/login');
  }

  void _onStartTap() {
    // TODO: Navigation vers l'inscription ou le profil
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body:
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  OnboardingHeroSection(onExplore: _scrollToContent),
                  SafeArea(child: OnboardingHeader(onLoginTap: _onLoginTap)),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 40.h),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return OnboardingFeatureCard(feature: features[index]);
              }, childCount: features.length),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  OnboardingPartners(partners: partners),
                  OnboardingFooter(onStartTap: _onStartTap),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
