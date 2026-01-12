import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final bool isHorizontal;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onBookmark,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isHorizontal ? 280.w : double.infinity,
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
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with bookmark
            Stack(
              children: [
                // Job image placeholder
                Container(
                  height: 110.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _getImageColor(job.imageUrl),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getIconForCategory(job.category),
                      size: 48.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),

                // Spots left badge
                if (job.spotsLeft <= 10)
                  Positioned(
                    bottom: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${job.spotsLeft} left',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ),
                  ),

                // Bookmark button
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: onBookmark,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        job.isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        size: 20.sp,
                        color: job.isSaved
                            ? ColorManager.authPrimary
                            : ColorManager.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Job details
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    job.title,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),

                  // Company and location
                  Text(
                    '${job.company} • ${job.location}',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s10.sp,
                      fontWeight: FontWeightManager.regular,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),

                  // Location and distance
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12.sp,
                        color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          job.address,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s10.sp,
                            fontWeight: FontWeightManager.regular,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        job.distance == 0
                            ? 'Remote'
                            : '${job.distance}km',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s10.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.authPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Date and time
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12.sp,
                        color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        job.dateFormatted,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s10.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.access_time,
                        size: 12.sp,
                        color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          job.timeRange,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s10.sp,
                            fontWeight: FontWeightManager.regular,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // Divider
                  Divider(
                    color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
                    height: 1,
                  ),
                  SizedBox(height: 6.h),

                  // Price
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${job.hourlyRate.toStringAsFixed(0)}/hr',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s14.sp,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.authPrimary,
                              ),
                            ),
                            Text(
                              '\$${job.expectedEarnings.toStringAsFixed(0)} exp',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s10.sp,
                                fontWeight: FontWeightManager.regular,
                                color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // DO Jobs badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.authSurface,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.work_outline,
                              size: 10.sp,
                              color: ColorManager.authPrimary,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              'DO',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s10.sp,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.authPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImageColor(String imageUrl) {
    switch (imageUrl) {
      case 'warehouse':
        return const Color(0xFF6366F1);
      case 'event':
        return const Color(0xFFF59E0B);
      case 'customer_support':
        return const Color(0xFF3B82F6);
      case 'landscaping':
        return const Color(0xFF10B981);
      case 'retail':
        return const Color(0xFFEC4899);
      case 'food_service':
        return const Color(0xFFEF4444);
      default:
        return ColorManager.authPrimary;
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'logistics':
        return Icons.local_shipping_outlined;
      case 'full time':
      case 'employer':
        return Icons.business_center_outlined;
      case 'retail':
        return Icons.shopping_bag_outlined;
      case 'f&b':
        return Icons.restaurant_outlined;
      case 'subscribe':
      case 'personal':
        return Icons.headset_mic_outlined;
      default:
        return Icons.work_outline;
    }
  }
}
