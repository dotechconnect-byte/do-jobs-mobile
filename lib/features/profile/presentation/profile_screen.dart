import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../../../core/providers/theme_provider.dart';

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

            // Settings Section
            _buildSettingsSection(context, isDark, themeProvider),

            SizedBox(height: 24.h),

            // Account Section
            _buildAccountSection(context, isDark),

            SizedBox(height: 24.h),

            // About Section
            _buildAboutSection(context, isDark),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ColorManager.authGradient,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Profile Picture
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.white,
                border: Border.all(
                  color: ColorManager.white,
                  width: 4,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 50.sp,
                color: ColorManager.authPrimary,
              ),
            ),

            SizedBox(height: 16.h),

            // Name
            Text(
              'Guest User',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s22.sp,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.white,
              ),
            ),

            SizedBox(height: 4.h),

            // Email
            Text(
              'guest@dojobs.com',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.white.withValues(alpha: 0.9),
              ),
            ),

            SizedBox(height: 16.h),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('12', 'Jobs Done', isDark),
                _buildStatCard('4.8', 'Rating', isDark),
                _buildStatCard('Silver', 'Tier', isDark),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s18.sp,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s11.sp,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.white.withValues(alpha: 0.9),
            ),
          ),
        ],
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
            'Settings',
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

          // Notifications
          _buildSettingItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            isDark: isDark,
            onTap: () {},
          ),

          _buildDivider(isDark),

          // Language
          _buildSettingItem(
            context,
            icon: Icons.language_outlined,
            title: 'Language',
            isDark: isDark,
            subtitle: 'English',
            onTap: () {},
          ),

          _buildDivider(isDark),

          // Privacy
          _buildSettingItem(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            isDark: isDark,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context, bool isDark) {
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
            'Account',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          _buildSettingItem(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            isDark: isDark,
            onTap: () {},
          ),

          _buildDivider(isDark),

          _buildSettingItem(
            context,
            icon: Icons.security_outlined,
            title: 'Security',
            isDark: isDark,
            onTap: () {},
          ),

          _buildDivider(isDark),

          _buildSettingItem(
            context,
            icon: Icons.account_balance_wallet_outlined,
            title: 'Payment Methods',
            isDark: isDark,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isDark) {
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
            'About',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          _buildSettingItem(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            isDark: isDark,
            onTap: () {},
          ),

          _buildDivider(isDark),

          _buildSettingItem(
            context,
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            isDark: isDark,
            onTap: () {},
          ),

          _buildDivider(isDark),

          _buildSettingItem(
            context,
            icon: Icons.info_outline,
            title: 'About DO Jobs',
            isDark: isDark,
            subtitle: 'Version 1.0.0',
            onTap: () {},
          ),

          _buildDivider(isDark),

          _buildSettingItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            isDark: isDark,
            titleColor: ColorManager.error,
            iconColor: ColorManager.error,
            onTap: () {},
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
}
