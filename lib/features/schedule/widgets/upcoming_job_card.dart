import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../models/schedule_job_model.dart';

class UpcomingJobCard extends StatelessWidget {
  final ScheduleJobModel job;
  final VoidCallback? onScanIn;

  const UpcomingJobCard({
    super.key,
    required this.job,
    this.onScanIn,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
        border: isDark
            ? Border.all(
                color: ColorManager.authPrimary.withValues(alpha: 0.3),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section with icon, title, and badge
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: isDark
                        ? ColorManager.authPrimary.withValues(alpha: 0.2)
                        : const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.work_outline_rounded,
                    size: 24.sp,
                    color: const Color(0xFF8B5CF6),
                  ),
                ),
                SizedBox(width: 12.w),

                // Title and company
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.bold,
                          color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        job.company,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),

                // Upcoming badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? ColorManager.authPrimary.withValues(alpha: 0.2)
                        : const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'upcoming',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s10.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: const Color(0xFF8B5CF6),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 1,
              color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
            ),
          ),

          // Job details section
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Date and Time
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.calendar_today_rounded,
                        text: job.formattedDate,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.access_time_rounded,
                        text: '${job.startTime} - ${job.endTime}',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Location
                _buildInfoItem(
                  icon: Icons.location_on_rounded,
                  text: job.location,
                ),
                SizedBox(height: 16.h),

                // Bottom row with rate and scan button
                Row(
                  children: [
                    // Hourly rate
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? ColorManager.authPrimary.withValues(alpha: 0.2)
                              : const Color(0xFFF3E8FF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              size: 18.sp,
                              color: const Color(0xFF8B5CF6),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '\$${job.hourlyRate.toStringAsFixed(1)}/hr',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s14.sp,
                                fontWeight: FontWeightManager.bold,
                                color: const Color(0xFF8B5CF6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Scan In button
                    GestureDetector(
                      onTap: onScanIn,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF10B981),
                              Color(0xFF059669),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF10B981)
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.qr_code_scanner_rounded,
                              size: 18.sp,
                              color: ColorManager.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Scan In',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s13.sp,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s13.sp,
                  fontWeight: FontWeightManager.regular,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
