import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class RequirementsSection extends StatelessWidget {
  final List<String> requirements;

  const RequirementsSection({
    super.key,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requirements',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s16.sp,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        ...requirements.map((requirement) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4.h),
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: ColorManager.authPrimary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14.sp,
                      color: ColorManager.authPrimary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      requirement,
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
    );
  }
}
