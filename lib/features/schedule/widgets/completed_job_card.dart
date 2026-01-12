import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../models/schedule_job_model.dart';

class CompletedJobCard extends StatefulWidget {
  final ScheduleJobModel job;
  final VoidCallback? onTap;

  const CompletedJobCard({
    super.key,
    required this.job,
    this.onTap,
  });

  @override
  State<CompletedJobCard> createState() => _CompletedJobCardState();
}

class _CompletedJobCardState extends State<CompletedJobCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: isDark ? ColorManager.darkCard : ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border(
            left: BorderSide(
              color: const Color(0xFF10B981),
              width: 4.w,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon, title, and badge
              Row(
                children: [
                  // Check icon
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 24.sp,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Title and company
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.job.title,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s16.sp,
                            fontWeight: FontWeightManager.bold,
                            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.job.company,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s13.sp,
                            fontWeight: FontWeightManager.regular,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Completed badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.authPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Completed',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s10.sp,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.authPrimary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Date, Time row
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    widget.job.formattedDate,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.regular,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.access_time_outlined,
                    size: 14.sp,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      '${widget.job.startTime} - ${widget.job.endTime}',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s12.sp,
                        fontWeight: FontWeightManager.regular,
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // Location
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14.sp,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      widget.job.location,
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s12.sp,
                        fontWeight: FontWeightManager.regular,
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Stats cards row - always visible
              Row(
                children: [
                  // Hours Worked
                  Expanded(
                    child: _buildStatCard(
                      context,
                      label: 'Hours',
                      value: '8 hrs',
                      bgColor: isDark
                          ? ColorManager.authPrimary.withValues(alpha: 0.1)
                          : const Color(0xFFF5F3FF),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Total Payment
                  Expanded(
                    child: _buildStatCard(
                      context,
                      label: 'Payment',
                      value: '\$${(widget.job.hourlyRate * 8).toStringAsFixed(0)}',
                      bgColor: const Color(0xFF10B981).withValues(alpha: 0.1),
                      valueColor: const Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Payment Status
                  Expanded(
                    child: _buildStatCard(
                      context,
                      label: 'Status',
                      value: 'Paid',
                      bgColor: const Color(0xFF10B981).withValues(alpha: 0.1),
                      valueColor: const Color(0xFF10B981),
                      icon: Icons.check_circle,
                    ),
                  ),
                ],
              ),

              // Expand/Collapse indicator
              SizedBox(height: 12.h),
              Center(
                child: Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 24.sp,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ),

              // Expandable content
              if (_isExpanded) ...[
                SizedBox(height: 16.h),

                // Employer Feedback section
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                        : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up_outlined,
                            size: 16.sp,
                            color: const Color(0xFF3B82F6),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Employer Feedback',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s13.sp,
                                fontWeight: FontWeightManager.semiBold,
                                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                              ),
                            ),
                          ),
                          ...List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 14.sp,
                              color: const Color(0xFFFBBF24),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Excellent work! Very professional and punctual. Customers loved their service.',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark
                              ? ColorManager.darkTextSecondary
                              : const Color(0xFF1E40AF),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Your Feedback section
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? ColorManager.authPrimary.withValues(alpha: 0.1)
                        : const Color(0xFFFAF5FF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 16.sp,
                            color: ColorManager.authPrimary,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Your Feedback',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s13.sp,
                              fontWeight: FontWeightManager.semiBold,
                              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Rating categories
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 8.h,
                        children: [
                          _buildRatingCategory(context, 'Location', 4),
                          _buildRatingCategory(context, 'Meals', 5),
                          _buildRatingCategory(context, 'Supervisor', 5),
                          _buildRatingCategory(context, 'Work Again', 5),
                          _buildRatingCategory(context, 'Facilities', 4),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      Text(
                        'Great experience overall. The management was supportive and the work environment was pleasant.',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Edit Feedback button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to edit feedback
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 16.sp,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                    label: Text(
                      'Edit Feedback',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s13.sp,
                        fontWeight: FontWeightManager.medium,
                        color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: BorderSide(
                        color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required Color bgColor,
    Color? valueColor,
    IconData? icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s10.sp,
              fontWeight: FontWeightManager.regular,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 12.sp,
                  color: valueColor ?? (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
                ),
                SizedBox(width: 4.w),
              ],
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.bold,
                    color: valueColor ?? (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCategory(BuildContext context, String label, int rating) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s10.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => Icon(
              Icons.star,
              size: 12.sp,
              color: index < rating ? const Color(0xFFFBBF24) : ColorManager.grey4,
            ),
          ),
        ),
      ],
    );
  }
}
