import 'package:flutter/material.dart';

class OnboardingHeroSection extends StatelessWidget {
  final VoidCallback onExplore;

  const OnboardingHeroSection({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return SizedBox(
      width: double.infinity,
      height: screenHeight - statusBarHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding0.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF0D3D35),
                  child: CustomPaint(painter: VerticalLinesPainter()),
                );
              },
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: VerticalLinesPainter())),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.15, 0.5, 1.0],
                colors: [
                  const Color(0xFF0D3D35).withOpacity(0.85),
                  const Color(0xFF0D3D35).withOpacity(0.2),
                  const Color(0xFF0D3D35).withOpacity(0.7),
                  const Color(0xFF0D3D35).withOpacity(0.95),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.38),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 3,
                      height: 120,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10E8A4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LA VOIE À SUIVRE',
                            style: TextStyle(
                              color: Color(0xFF10E8A4),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                height: 1.15,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.5,
                              ),
                              children: [
                                TextSpan(text: 'Votre Avenir,\n'),
                                TextSpan(
                                  text: 'Architecturé.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Guidez votre transition du lycée à l\'université avec une précision intelligente et un contexte culturel adapté.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.5,
                    height: 1.65,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.1,
                  ),
                ),
                const Spacer(),
                Center(
                  child: TextButton(
                    onPressed: onExplore,
                    child: Column(
                      children: [
                        Text(
                          'EXPLORER',
                          style: TextStyle(
                            color: const Color(0xFFB8A992),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: const Color(0xFFB8A992),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB8A992).withOpacity(0.15)
      ..strokeWidth = 1.5;

    const lineSpacing = 45.0;
    for (double x = 0; x < size.width; x += lineSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
