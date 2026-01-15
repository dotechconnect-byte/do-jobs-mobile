import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
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
          'Personal Details',
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
              color: ColorManager.authPrimary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Submitted',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.white,
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
              'Your personal information and identification details',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFF1976D2),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Verification Required: Personal details must be verified to apply for part-time job opportunities.',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s12.sp,
                        fontWeight: FontWeightManager.medium,
                        color: const Color(0xFF1976D2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: Text(
                'Detailed form content will be added here based on your screenshots',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.regular,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Submit profile
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.authPrimary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Submit Profile',
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
}
