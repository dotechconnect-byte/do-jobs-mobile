import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';

class JobTypesScreen extends StatefulWidget {
  const JobTypesScreen({super.key});

  @override
  State<JobTypesScreen> createState() => _JobTypesScreenState();
}

class _JobTypesScreenState extends State<JobTypesScreen> {
  final Set<String> _selectedJobTypes = {'Part-Time Jobs', 'Work From Home', 'Other Job Types'};

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
          'Job Types I\'m Looking For',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.semiBold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the types of jobs you\'re interested in. Some require verification to unlock.',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            _buildJobTypeCard(
              context,
              isDark,
              'Part-Time Jobs',
              'Flexible hours, ideal for students and those with other commitments',
              Icons.access_time,
              isSelected: _selectedJobTypes.contains('Part-Time Jobs'),
              isVerified: true,
            ),
            SizedBox(height: 12.h),
            _buildJobTypeCard(
              context,
              isDark,
              'Full-Time Jobs',
              'Permanent positions with full benefits and career growth',
              Icons.business_center,
              isSelected: _selectedJobTypes.contains('Full-Time Jobs'),
              isVerified: true,
            ),
            SizedBox(height: 12.h),
            _buildJobTypeCard(
              context,
              isDark,
              'Work From Home',
              'Remote opportunities you can do from anywhere',
              Icons.home_outlined,
              isSelected: _selectedJobTypes.contains('Work From Home'),
              isVerified: false,
              readyToApply: true,
            ),
            SizedBox(height: 12.h),
            _buildJobTypeCard(
              context,
              isDark,
              'Other Job Types',
              'Contract work, freelance, gigs, and flexible arrangements',
              Icons.more_horiz,
              isSelected: _selectedJobTypes.contains('Other Job Types'),
              isVerified: false,
              readyToApply: true,
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorManager.authPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: ColorManager.authPrimary,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Looking for ${_selectedJobTypes.length} job types',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _selectedJobTypes.join(', '),
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s12.sp,
                            fontWeight: FontWeightManager.regular,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save preferences
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
                  'Save Preferences',
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

  Widget _buildJobTypeCard(
    BuildContext context,
    bool isDark,
    String title,
    String description,
    IconData icon, {
    required bool isSelected,
    bool isVerified = false,
    bool readyToApply = false,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedJobTypes.remove(title);
          } else {
            _selectedJobTypes.add(title);
          }
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.authPrimary.withValues(alpha: 0.1)
              : (isDark ? ColorManager.darkCard : ColorManager.white),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.authPrimary
                : (isDark ? ColorManager.darkBorder : ColorManager.grey4),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? ColorManager.authPrimary : ColorManager.grey3,
                  width: 2,
                ),
                color: isSelected ? ColorManager.authPrimary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: ColorManager.white,
                    )
                  : null,
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
                      fontWeight: FontWeightManager.semiBold,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
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
            if (isVerified)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF06D6A0),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified,
                      color: ColorManager.white,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Verified',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s11.sp,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              )
            else if (readyToApply)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorManager.authPrimary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: ColorManager.white,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Ready to Apply',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s11.sp,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
