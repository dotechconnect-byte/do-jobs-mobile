import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../data/mock_schedule.dart';
import '../widgets/upcoming_job_card.dart';
import '../widgets/completed_job_card.dart';
import 'calendar_view_screen.dart';

class MyScheduleScreen extends StatefulWidget {
  const MyScheduleScreen({super.key});

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        _buildHeader(context),

        // T
        _buildTabs(),

        SizedBox(height: 16.h),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildUpcomingTab(),
              _buildCompletedTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8B5CF6),
            Color(0xFF7C3AED),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.work_outline_rounded,
            size: 24.sp,
            color: ColorManager.white,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Schedule',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s20.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Track your jobs and set your availability',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          // Calendar icon button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarViewScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorManager.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                size: 24.sp,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: isDark ? ColorManager.darkCard : ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8B5CF6),
                Color(0xFF7C3AED),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          labelColor: ColorManager.white,
          unselectedLabelColor: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
          labelStyle: GoogleFonts.poppins(
            fontSize: FontSize.s12.sp,
            fontWeight: FontWeightManager.semiBold,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: FontSize.s12.sp,
            fontWeight: FontWeightManager.medium,
          ),
          dividerColor: Colors.transparent,
          padding: EdgeInsets.all(4.w),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_outline_rounded,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      'Upcoming Jobs',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      'Completed Jobs',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    final upcomingJobs = MockSchedule.upcomingJobs;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Section header with count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Text(
                'Upcoming Shifts',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s18.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFF7C3AED),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${upcomingJobs.length}',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Job list
        Expanded(
          child: upcomingJobs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy_rounded,
                        size: 80.sp,
                        color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No upcoming shifts',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Apply for jobs to see them here',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: upcomingJobs.length,
                  itemBuilder: (context, index) {
                    return UpcomingJobCard(
                      job: upcomingJobs[index],
                      onScanIn: () {
                        _showScanInDialog(context);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCompletedTab() {
    final completedJobs = MockSchedule.completedJobs;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Text(
                'Completed Shifts',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s18.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.authSurface,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${completedJobs.length}',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.authPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Completed jobs list
        Expanded(
          child: completedJobs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 80.sp,
                        color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No completed shifts yet',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Your completed job history will appear here',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.regular,
                          color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: completedJobs.length,
                  itemBuilder: (context, index) {
                    return CompletedJobCard(
                      job: completedJobs[index],
                      onTap: () {
                        // TODO: Navigate to completed job details
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showScanInDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF10B981),
                    Color(0xFF059669),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.qr_code_scanner_rounded,
                size: 40.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'QR Code Scanner',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s20.sp,
                fontWeight: FontWeightManager.bold,
                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'This feature will open the QR code scanner to scan in for your shift.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: ColorManager.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Got it',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
