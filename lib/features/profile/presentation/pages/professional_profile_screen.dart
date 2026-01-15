import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';

class ProfessionalProfileScreen extends StatefulWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  State<ProfessionalProfileScreen> createState() => _ProfessionalProfileScreenState();
}

class _ProfessionalProfileScreenState extends State<ProfessionalProfileScreen> {
  bool _isBioExpanded = false;
  bool _isJobPreferencesExpanded = false;
  bool _isAvailabilityExpanded = false;
  bool _isSkillsExpanded = false;
  bool _isCertificationsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Professional Profile',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.semiBold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorManager.grey3,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Optional',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enhance your profile with professional details',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            _buildProfessionalSection(
              context,
              isDark,
              Icons.description_outlined,
              'Bio',
              _isBioExpanded,
              () {
                setState(() {
                  _isBioExpanded = !_isBioExpanded;
                });
              },
            ),
            SizedBox(height: 12.h),
            _buildProfessionalSection(
              context,
              isDark,
              Icons.work_outline,
              'Job Preferences',
              _isJobPreferencesExpanded,
              () {
                setState(() {
                  _isJobPreferencesExpanded = !_isJobPreferencesExpanded;
                });
              },
            ),
            SizedBox(height: 12.h),
            _buildProfessionalSection(
              context,
              isDark,
              Icons.calendar_today_outlined,
              'Availability & Schedule',
              _isAvailabilityExpanded,
              () {
                setState(() {
                  _isAvailabilityExpanded = !_isAvailabilityExpanded;
                });
              },
            ),
            SizedBox(height: 12.h),
            _buildProfessionalSection(
              context,
              isDark,
              Icons.star_outline,
              'Skills',
              _isSkillsExpanded,
              () {
                setState(() {
                  _isSkillsExpanded = !_isSkillsExpanded;
                });
              },
            ),
            SizedBox(height: 12.h),
            _buildProfessionalSection(
              context,
              isDark,
              Icons.verified_outlined,
              'Certifications & Licenses',
              _isCertificationsExpanded,
              () {
                setState(() {
                  _isCertificationsExpanded = !_isCertificationsExpanded;
                });
              },
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save professional profile
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.authPrimary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Save Profile',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalSection(
    BuildContext context,
    bool isDark,
    IconData icon,
    String title,
    bool isExpanded,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? ColorManager.darkCard : ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.authPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    icon,
                    color: ColorManager.authPrimary,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ],
            ),
            if (isExpanded) ...[
              SizedBox(height: 16.h),
              Divider(
                height: 1,
                thickness: 1,
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
              SizedBox(height: 16.h),
              Text(
                'Content for $title will be added here',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s12.sp,
                  fontWeight: FontWeightManager.regular,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
