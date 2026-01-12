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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.authPrimary.withValues(alpha: 0.15),
                  ColorManager.authPrimaryDark.withValues(alpha: 0.1),
                ],
              )
            : null,
        color: isDark ? null : ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? ColorManager.authPrimary.withValues(alpha: 0.3) : ColorManager.grey4,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildRow(context, 'Monthly Salary', '\$${monthlySalary.toStringAsFixed(0)}/mo', false),
          SizedBox(height: 10.h),
          _buildRow(context, 'Annual Package', '\$${annualPackage.toStringAsFixed(0)}/year', false),
          SizedBox(height: 10.h),
          _buildRow(context, '+ Benefits', '\$${monthlyBenefits.toStringAsFixed(0)}/mo', false),
          SizedBox(height: 14.h),
          Divider(color: isDark ? ColorManager.darkBorder : ColorManager.grey4, height: 1),
          SizedBox(height: 14.h),
          _buildRow(context, 'Total Package', '\$${totalPackage.toStringAsFixed(0)}/year', true),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value, bool isTotal) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? FontSize.s15.sp : FontSize.s13.sp,
            fontWeight: isTotal ? FontWeightManager.bold : FontWeightManager.regular,
            color: isTotal
                ? (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary)
                : (isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? FontSize.s16.sp : FontSize.s13.sp,
            fontWeight: isTotal ? FontWeightManager.bold : FontWeightManager.semiBold,
            color: isTotal
                ? const Color(0xFF10B981)
                : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
          ),
        ),
      ],
    );
  }
}
