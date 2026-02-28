import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/state/auth_state.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState is AuthAuthenticated ? authState.user : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profile Avatar with Gold Border
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: const BoxDecoration(
            color: Color(0xFFD4B46E),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 22.r,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=${user?.email ?? 'user'}',
            ),
          ),
        ),
        // Notification Icon in Dark Circle
        Container(
          width: 44.w,
          height: 44.w,
          decoration: const BoxDecoration(
            color: Color(0xFF14241F),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                color: Colors.white70,
                size: 24.w,
              ),
              PositionNotifier(top: 13.h, right: 14.w),
            ],
          ),
        ),
      ],
    );
  }
}

class PositionNotifier extends StatelessWidget {
  final double top;
  final double right;
  const PositionNotifier({super.key, required this.top, required this.right});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Container(
        width: 8.w,
        height: 8.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
