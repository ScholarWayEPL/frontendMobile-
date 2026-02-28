import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/widgets/auth_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/state/auth_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState is AuthAuthenticated ? authState.user : null;

    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(user),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    _buildCompletionProgress(),
                    SizedBox(height: 30.h),
                    _buildMenuSection(context, ref),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(dynamic user) {
    final String fullName = user != null
        ? '${user.prenom} ${user.nom}'
        : 'Utilisateur';
    final String email = user?.email ?? '';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AuthColors.cardBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD4B46E), width: 3.w),
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pravatar.cc/300?u=${user?.email ?? 'user'}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            fullName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            email,
            style: TextStyle(color: AuthColors.white40, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionProgress() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AuthColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AuthColors.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Complétion du Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '65%',
                style: TextStyle(
                  color: const Color(0xFF10E8A4),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 8.h,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF10E8A4),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            'Complétez votre parcours pour débloquer les meilleures recommandations d\'universités.',
            style: TextStyle(color: AuthColors.white40, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.auto_awesome_outlined,
          title: 'Compléter mon parcours',
          subtitle: 'Académique, Budget, Carrière',
          onTap: () => context.push('/profile/complete'),
          color: const Color(0xFFD4B46E),
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          title: 'Mes Documents',
          subtitle: 'Relevés de notes, BAC 1 & 2',
          onTap: () => context.push('/profile/documents'),
          color: const Color(0xFF9489F5),
        ),
        _buildMenuItem(
          icon: Icons.person_outline_rounded,
          title: 'Informations Personnelles',
          subtitle: 'Nom, Email, Téléphone',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.security_outlined,
          title: 'Sécurité',
          subtitle: 'Mot de passe, Double auth',
          onTap: () {},
        ),
        SizedBox(height: 20.h),
        _buildMenuItem(
          icon: Icons.logout_rounded,
          title: 'Déconnexion',
          onTap: () {
            ref.read(authNotifierProvider.notifier).logout();
            context.go('/login');
          },
          isError: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? color,
    bool isError = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AuthColors.cardBackground.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: AuthColors.fieldBorder.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: (color ?? Colors.white).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: isError
                      ? Colors.redAccent
                      : (color ?? AuthColors.white70),
                  size: 24.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isError ? Colors.redAccent : Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: AuthColors.white40,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AuthColors.white20,
                size: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
