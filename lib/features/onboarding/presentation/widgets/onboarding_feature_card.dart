import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_feature.dart';

class OnboardingFeatureCard extends StatelessWidget {
  final OnboardingFeature feature;

  const OnboardingFeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 32, 61, 53),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 22, 99, 77).withOpacity(0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10E8A4).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getIconData(feature.icon),
                        color: const Color(0xFF10E8A4),
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      feature.number,
                      style: TextStyle(
                        color: const Color(0xFFB8A992).withOpacity(0.25),
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        height: 0.8,
                        letterSpacing: -2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  feature.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  feature.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13.5,
                    height: 1.55,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (feature.imageUrl != null && feature.imageUrl!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  color: const Color(0xFF2A3A35),
                  child: Image.asset(
                    feature.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderImage();
                    },
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A3A35), Color(0xFF1A2A25)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.groups_outlined,
          size: 64,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'ai':
        return Icons.psychology_outlined;
      case 'finance':
        return Icons.account_balance_outlined;
      case 'school':
        return Icons.school_outlined;
      default:
        return Icons.star_outline;
    }
  }
}
