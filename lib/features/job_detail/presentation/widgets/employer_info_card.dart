import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class EmployerInfoCard extends StatelessWidget {
  final String companyName;
  final String location;
  final bool isVerified;
  final String employeeCount;
  final int openRoles;
  final double rating;
  final String aboutCompany;

  const EmployerInfoCard({
    super.key,
    required this.companyName,
    required this.location,
    required this.isVerified,
    required this.employeeCount,
    required this.openRoles,
    required this.rating,
    required this.aboutCompany,
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
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: ColorManager.authPrimary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.business,
                  size: 24.sp,
                  color: ColorManager.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            companyName,
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s16.sp,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.textPrimary,
                            ),
                          ),
                        ),
                        if (isVerified)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12.sp,
                                  color: ColorManager.white,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Verified',
                                  style: GoogleFonts.poppins(
                                    fontSize: FontSize.s10.sp,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s12.sp,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(
                Icons.people_outline,
                employeeCount,
                'Employees',
                const Color(0xFF3B82F6),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: ColorManager.grey4,
              ),
              _buildStat(
                Icons.work_outline,
                '$openRoles',
                'Open Roles',
                const Color(0xFF8B5CF6),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: ColorManager.grey4,
              ),
              _buildStat(
                Icons.star_outline,
                '$rating★',
                'Rating',
                const Color(0xFFF59E0B),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            aboutCompany,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.sp,
          color: color,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s16.sp,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s12.sp,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textSecondary,
          ),
        ),
      ],
    );
  }
}
