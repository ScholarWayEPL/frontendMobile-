import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestMatchSection extends StatelessWidget {
  const BestMatchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Meilleure Correspondance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'VOIR TOUT',
              style: TextStyle(
                color: const Color(0xFFD4B46E),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        const BestMatchCard(),
      ],
    );
  }
}

class BestMatchCard extends StatelessWidget {
  const BestMatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF14241F),
        borderRadius: BorderRadius.circular(24.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Map Background with Overlay
          Column(
            children: [
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D3D35), // Fallback color
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1541339907198-e08756ebafe3?q=80&w=800&auto=format&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        const Color(0xFF14241F),
                      ],
                    ),
                  ),
                ),
              ),
              // Content Area below map
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FILIÈRE RECOMMANDÉE',
                      style: TextStyle(
                        color: const Color(0xFFD4B46E),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Informatique & Systèmes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoBox(
                            icon: Icons.account_balance_wallet_outlined,
                            label: 'SCOLARITÉ EST.',
                            value: '5,2M XOF/an',
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _buildInfoBox(
                            icon: Icons.trending_up,
                            label: 'INSERTION',
                            value: 'Taux 96%',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Floating overlay elements on Map
          Positioned(
            top: 20.h,
            left: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xFFD4B46E),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'TOP CHOIX',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            left: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Université Ashesi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: const Color(0xFFD4B46E),
                      size: 14.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Berekuso, Ghana',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.sp,
                        shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Score Badge
          Positioned(
            top: 120.h,
            right: 20.w,
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Color(0xFF10E8A4), Color(0xFF0D3D35)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '94',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF10E8A4), size: 20.w),
          SizedBox(height: 10.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
