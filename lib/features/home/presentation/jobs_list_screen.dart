import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../../auth/presentation/pages/auth_screen.dart';
import '../../job_detail/data/mock_job_detail.dart';
import '../../job_detail/presentation/pages/job_detail_screen.dart';
import '../models/job_model.dart';

class JobsListScreen extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<JobModel> jobs;
  final bool isGuest;

  const JobsListScreen({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.jobs,
    this.isGuest = true,
  });

  @override
  State<JobsListScreen> createState() => _JobsListScreenState();
}

class _JobsListScreenState extends State<JobsListScreen> {
  void _handleRestrictedAccess() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorManager.authGradient,
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.lock_rounded,
                size: 40.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Sign In Required',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s24.sp,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Please sign in to access this feature and unlock all the amazing opportunities.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.authPrimary,
                  foregroundColor: ColorManager.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Sign In / Sign Up',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Maybe Later',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.authBackground,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20.sp,
            color: ColorManager.textPrimary,
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: ColorManager.authGradient,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  widget.icon,
                  size: 18.sp,
                  color: ColorManager.white,
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s18.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.textSecondary,
                    ),
                  ),
              ],
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: widget.jobs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_off_outlined,
                    size: 80.sp,
                    color: ColorManager.textTertiary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No jobs available',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s16.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Check back later for new opportunities',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.textTertiary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: widget.jobs.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return _buildJobCard(widget.jobs[index]);
              },
            ),
    );
  }

  Widget _buildJobCard(JobModel job) {
    return GestureDetector(
      onTap: () {
        // Navigate to job detail screen (accessible to all users)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailScreen(
              job: MockJobDetail.getWarehouseJob(),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorManager.authPrimary,
                    ColorManager.authPrimary.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.work_outline_rounded,
                      size: 40.sp,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  // Bookmark button
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: widget.isGuest
                          ? _handleRestrictedAccess
                          : () {
                              // Handle bookmark for logged-in users
                            },
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(6.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.bookmark_outline,
                          size: 16.sp,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  // Badge
                  if (job.isHotShift || job.isAISuggested)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: job.isHotShift
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF8B5CF6),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              job.isHotShift
                                  ? Icons.local_fire_department_rounded
                                  : Icons.auto_awesome_rounded,
                              size: 10.sp,
                              color: ColorManager.white,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              job.isHotShift ? 'Hot' : 'AI Pick',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s10.sp,
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
            ),
            // Content section
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and company
                  Text(
                    job.title,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    job.company,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // Location and distance
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: ColorManager.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          job.location,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s11.sp,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (job.distance > 0) ...[
                        Text(
                          '${job.distance.toStringAsFixed(1)} km',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s11.sp,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.authPrimary,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // Date and time
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 14.sp,
                        color: ColorManager.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDate(job.date),
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s11.sp,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: ColorManager.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${job.startTime} - ${job.endTime}',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s11.sp,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  // Divider
                  Container(
                    height: 1,
                    color: ColorManager.grey4,
                  ),
                  SizedBox(height: 10.h),

                  // Bottom row
                  Row(
                    children: [
                      // Hourly rate
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hourly Rate',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s10.sp,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '\$${job.hourlyRate.toStringAsFixed(2)}/hr',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s14.sp,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.authPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expected earnings
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expected',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s10.sp,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '\$${job.expectedEarnings.toStringAsFixed(0)}',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s14.sp,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spots left
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: job.spotsLeft <= 3
                              ? const Color(0xFFFEF2F2)
                              : ColorManager.authSurface,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people_outline_rounded,
                              size: 14.sp,
                              color: job.spotsLeft <= 3
                                  ? const Color(0xFFEF4444)
                                  : ColorManager.authPrimary,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              '${job.spotsLeft} left',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s11.sp,
                                fontWeight: FontWeightManager.semiBold,
                                color: job.spotsLeft <= 3
                                    ? const Color(0xFFEF4444)
                                    : ColorManager.authPrimary,
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final jobDate = DateTime(date.year, date.month, date.day);

    if (jobDate == today) {
      return 'Today';
    } else if (jobDate == tomorrow) {
      return 'Tomorrow';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}';
    }
  }
}
