import 'package:flutter/material.dart';
import '../../domain/entities/partner.dart';

class OnboardingPartners extends StatelessWidget {
  final List<Partner> partners;

  const OnboardingPartners({super.key, required this.partners});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Text(
            'LA CONFIANCE DES FUTURS LEADERS',
            style: TextStyle(
              color: const Color(0xFFB8A992),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: partners.map((partner) {
              return _buildPartnerLogo(partner);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerLogo(Partner partner) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4A42).withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFB8A992).withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance,
            color: const Color(0xFFB8A992).withOpacity(0.7),
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            partner.name,
            style: TextStyle(
              color: const Color(0xFFB8A992).withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
