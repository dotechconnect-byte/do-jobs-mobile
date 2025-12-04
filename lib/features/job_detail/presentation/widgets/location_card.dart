import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class LocationCard extends StatelessWidget {
  final String location;
  final VoidCallback onOpenMaps;

  const LocationCard({
    super.key,
    required this.location,
    required this.onOpenMaps,
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
                Icons.location_on,
                size: 20.sp,
                color: ColorManager.authPrimary,
              ),
              SizedBox(width: 8.w),
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            location,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onOpenMaps,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.grey6,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 18.sp,
                    color: ColorManager.textPrimary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Open in Maps',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.open_in_new,
                    size: 16.sp,
                    color: ColorManager.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
