import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class BenefitsSection extends StatelessWidget {
  final List<String> benefits;

  const BenefitsSection({
    super.key,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.grey4,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star_outline,
                size: 20.sp,
                color: const Color(0xFF10B981),
              ),
              SizedBox(width: 8.w),
              Text(
                'Benefits & Perks',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s16.sp,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...benefits.map((benefit) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 14.sp,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        benefit,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
