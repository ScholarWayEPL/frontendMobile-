import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  final VoidCallback onStartTap;

  const OnboardingFooter({super.key, required this.onStartTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onStartTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10E8A4),
                foregroundColor: const Color(0xFF0D3D35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Commencer l\'Aventure',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 17),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'En continuant, vous acceptez nos Conditions & Politique de\nConfidentialité.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFB8A992).withOpacity(0.5),
              fontSize: 10,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
