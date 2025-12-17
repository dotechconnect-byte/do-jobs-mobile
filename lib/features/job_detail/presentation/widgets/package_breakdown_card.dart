import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';

class PackageBreakdownCard extends StatelessWidget {
  final double monthlySalary;
  final double annualPackage;
  final double monthlyBenefits;
  final double totalPackage;

  const PackageBreakdownCard({
    super.key,
    required this.monthlySalary,
    required this.annualPackage,
    required this.monthlyBenefits,
    required this.totalPackage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.grey4,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildRow('Monthly Salary', '\$${monthlySalary.toStringAsFixed(0)}/mo', false),
          SizedBox(height: 10.h),
          _buildRow('Annual Package', '\$${annualPackage.toStringAsFixed(0)}/year', false),
          SizedBox(height: 10.h),
          _buildRow('+ Benefits', '\$${monthlyBenefits.toStringAsFixed(0)}/mo', false),
          SizedBox(height: 14.h),
          Divider(color: ColorManager.grey4, height: 1),
          SizedBox(height: 14.h),
          _buildRow('Total Package', '\$${totalPackage.toStringAsFixed(0)}/year', true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? FontSize.s15.sp : FontSize.s13.sp,
            fontWeight: isTotal ? FontWeightManager.bold : FontWeightManager.regular,
            color: isTotal ? ColorManager.textPrimary : ColorManager.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? FontSize.s16.sp : FontSize.s13.sp,
            fontWeight: isTotal ? FontWeightManager.bold : FontWeightManager.semiBold,
            color: isTotal ? const Color(0xFF10B981) : ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }
}
