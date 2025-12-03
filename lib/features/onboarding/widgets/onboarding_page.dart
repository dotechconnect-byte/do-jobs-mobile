import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/font_manager.dart';
import '../models/onboarding_model.dart';
import 'animated_onboarding_icon.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final bool isActive;

  const OnboardingPage({
    super.key,
    required this.model,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: model.gradientColors,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
          child: Column(
            children: [
              const Spacer(),
              // Animated Icon
              AnimatedOnboardingIcon(
                icon: model.iconData,
                iconColor: Colors.white,
                size: 140.w,
                isActive: isActive,
              ),
              SizedBox(height: 60.h),
              // Title
              AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                child: Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Description
              AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                child: Text(
                  model.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
              ),
              if (model.additionalInfo != null) ...[
                SizedBox(height: 16.h),
                AnimatedOpacity(
                  opacity: isActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      model.additionalInfo!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
