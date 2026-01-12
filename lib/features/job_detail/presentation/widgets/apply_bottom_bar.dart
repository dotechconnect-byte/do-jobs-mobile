import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class ApplyBottomBar extends StatelessWidget {
  final String packageAmount;
  final VoidCallback onApply;
  final VoidCallback onShare;

  const ApplyBottomBar({
    super.key,
    required this.packageAmount,
    required this.onApply,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkSurface : ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Annual Package',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.regular,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                  ),
                  Text(
                    packageAmount,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s20.sp,
                      fontWeight: FontWeightManager.bold,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // Share button
              GestureDetector(
                onTap: onShare,
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: isDark ? ColorManager.darkInput : ColorManager.grey6,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.share_outlined,
                    size: 20.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Apply button
              Expanded(
                child: GestureDetector(
                  onTap: onApply,
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
