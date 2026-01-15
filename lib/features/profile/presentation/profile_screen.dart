import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../../../core/providers/theme_provider.dart';
import 'pages/job_types_screen.dart';
import 'pages/personal_details_screen.dart';
import 'pages/professional_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(context, isDark),

            SizedBox(height: 24.h),

            // Job Types Tile
            _buildNavigationTile(
              context,
              isDark,
              icon: Icons.work_outline,
              title: 'Job Types I\'m Looking For',
              subtitle: 'Select the types of jobs you\'re interested in',
              badge: 'Looking for 3',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JobTypesScreen()),
                );
              },
            ),

            SizedBox(height: 16.h),

            // Personal Details Tile
            _buildNavigationTile(
              context,
              isDark,
              icon: Icons.person_outline,
              title: 'Personal Details',
              subtitle: 'Your personal information and identification',
              badge: 'Submitted',
              badgeColor: ColorManager.authPrimary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()),
                );
              },
            ),

            SizedBox(height: 16.h),

            // Professional Profile Tile
            _buildNavigationTile(
              context,
              isDark,
              icon: Icons.business_center_outlined,
              title: 'Professional Profile',
              subtitle: 'Enhance your profile with professional details',
              badge: 'Optional',
              badgeColor: ColorManager.grey3,
              badgeTextColor: ColorManager.textSecondary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfessionalProfileScreen()),
                );
              },
            ),

            SizedBox(height: 24.h),

            // Settings Section (Dark Mode & Chat)
            _buildSettingsSection(context, isDark, themeProvider),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ColorManager.authGradient,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: ColorManager.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'My Profile',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s22.sp,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Manage your personal information and documents',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s12.sp,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF06D6A0),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: ColorManager.white,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Submitted',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s11.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Completion',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  '50%',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: ColorManager.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFD79A8)),
                minHeight: 8.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String title,
    required String subtitle,
    String? badge,
    Color? badgeColor,
    Color? badgeTextColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: ColorManager.authPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    icon,
                    color: ColorManager.authPrimary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s15.sp,
                                fontWeight: FontWeightManager.semiBold,
                                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                              ),
                            ),
                          ),
                          if (badge != null) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: badgeColor ?? ColorManager.authPrimary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                badge,
                                style: GoogleFonts.poppins(
                                  fontSize: FontSize.s10.sp,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: badgeTextColor ?? ColorManager.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, bool isDark, ThemeProvider themeProvider) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkCard : ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings & Support',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          // Dark Mode Toggle
          _buildSettingItem(
            context,
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            isDark: isDark,
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeTrackColor: ColorManager.authPrimary,
              activeThumbColor: ColorManager.white,
            ),
          ),

          _buildDivider(isDark),

          // Chat
          _buildSettingItem(
            context,
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Chat',
            subtitle: 'Connect with support and teams',
            isDark: isDark,
            onTap: () => _openChat(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isDark,
    String? subtitle,
    Color? titleColor,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: (iconColor ?? ColorManager.authPrimary).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: iconColor ?? ColorManager.authPrimary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.medium,
                      color: titleColor ?? (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s12.sp,
                        fontWeight: FontWeightManager.regular,
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (onTap != null)
              Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
    );
  }

  void _openChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Chat'),
          ),
          body: const _ChatPlaceholder(),
        ),
      ),
    );
  }
}

class _ChatPlaceholder extends StatelessWidget {
  const _ChatPlaceholder();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8B5CF6),
                    Color(0xFF7C3AED),
                  ],
                ),
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 60.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Chat',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s24.sp,
                fontWeight: FontWeightManager.bold,
                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8B5CF6),
                    Color(0xFF7C3AED),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Available Soon',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.white,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Connect with employers and team members in real-time. This feature is coming soon!',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s16.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
