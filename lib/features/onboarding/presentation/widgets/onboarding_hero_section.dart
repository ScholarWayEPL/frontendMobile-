import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_widgets.dart';

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
                  color: AuthColors.background,
                  child: CustomPaint(painter: VerticalLinesPainter()),
                );
              },
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: VerticalLinesPainter())),
          // Gradient overlay that fades the image into the page background.
          // Keep the top strongly opaque so the header remains visible.
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.12, 0.5, 1.0],
                colors: [
    
                    Color.fromARGB(
                      (0.95 * 255).round(),
                      (AuthColors.background.value >> 16) & 0xFF,
                      (AuthColors.background.value >> 8) & 0xFF,
                      AuthColors.background.value & 0xFF),
                    Color.fromARGB(
                      (0.60 * 255).round(),
                      (AuthColors.background.value >> 16) & 0xFF,
                      (AuthColors.background.value >> 8) & 0xFF,
                      AuthColors.background.value & 0xFF),
                    Color.fromARGB(
                      (0.28 * 255).round(),
                      (AuthColors.background.value >> 16) & 0xFF,
                      (AuthColors.background.value >> 8) & 0xFF,
                      AuthColors.background.value & 0xFF),
                  AuthColors.background,
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
                      height: 150,
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
                          Text(
                            'LA VOIE À SUIVRE',
                            style: TextStyle(
                              color: Color(0xFF10E8A4),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.5,
                            ),
                          ),
                          SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 38.sp,
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
                SizedBox(height: 20.h),
                Text(
                  'Guidez votre transition du lycée à l\'université avec une précision intelligente et un contexte culturel adapté.',
                  style: TextStyle(
                    color: Color.fromARGB((0.8 * 255).round(), 255, 255, 255),
                    fontSize: 20.sp,
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
                            fontSize: 11.sp,
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
      ..color = Color.fromARGB((0.15 * 255).round(), 0xB8, 0xA9, 0x92)
      ..strokeWidth = 1.5;

    const lineSpacing = 45.0;
    for (double x = 0; x < size.width; x += lineSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
