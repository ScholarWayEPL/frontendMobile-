import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final VoidCallback onLoginTap;

  const OnboardingHeader({super.key, required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF10E8A4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.school, color: Colors.black, size: 16),
              ),
              const SizedBox(width: 10),
              const Text(
                'ScholarWay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onLoginTap,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'CONNEXION',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
