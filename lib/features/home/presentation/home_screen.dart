import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../../auth/presentation/pages/auth_screen.dart';
import '../../job_detail/data/mock_job_detail.dart';
import '../../job_detail/presentation/pages/job_detail_screen.dart';
import '../../schedule/presentation/my_schedule_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../wallet/presentation/wallet_screen.dart';
import '../data/mock_jobs.dart';
import '../models/job_model.dart';
import '../widgets/category_chips.dart';
import '../widgets/guest_bottom_nav.dart';
import '../widgets/job_card.dart';
import '../widgets/section_header.dart';
import 'jobs_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isGuest;

  const HomeScreen({
    super.key,
    this.isGuest = true,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String _selectedLocation = 'Downtown';
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;
  Timer? _bannerTimer;

  // Scroll controllers for job lists
  final ScrollController _hotShiftsController = ScrollController();
  final ScrollController _aiSuggestedController = ScrollController();
  final ScrollController _nearbyJobsController = ScrollController();
  final ScrollController _allJobsController = ScrollController();

  // Timers for job lists
  Timer? _hotShiftsTimer;
  Timer? _aiSuggestedTimer;
  Timer? _nearbyJobsTimer;
  Timer? _allJobsTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _startJobListAutoScroll();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerPageController.dispose();

    // Dispose job list timers and controllers
    _hotShiftsTimer?.cancel();
    _aiSuggestedTimer?.cancel();
    _nearbyJobsTimer?.cancel();
    _allJobsTimer?.cancel();
    _hotShiftsController.dispose();
    _aiSuggestedController.dispose();
    _nearbyJobsController.dispose();
    _allJobsController.dispose();

    super.dispose();
  }

  void _startAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_bannerPageController.hasClients) {
        final nextPage = (_currentBannerPage + 1) % 3;
        _bannerPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _startJobListAutoScroll() {
    // Auto-scroll for Hot Shifts every 2.5 seconds
    _hotShiftsTimer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
      _autoScrollList(_hotShiftsController);
    });

    // Auto-scroll for AI Suggested every 3 seconds
    _aiSuggestedTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _autoScrollList(_aiSuggestedController);
    });

    // Auto-scroll for Nearby Jobs every 3.5 seconds
    _nearbyJobsTimer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      _autoScrollList(_nearbyJobsController);
    });

    // Auto-scroll for All Jobs every 4 seconds
    _allJobsTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _autoScrollList(_allJobsController);
    });
  }

  void _autoScrollList(ScrollController controller) {
    if (!controller.hasClients) return;

    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;

    // If we're at the beginning or in the middle, scroll forward
    if (currentScroll < maxScroll) {
      final cardWidth = 280.w + 16.w; // Card width + separator
      double nextScroll = currentScroll + cardWidth;

      // If next scroll would exceed max, scroll to max
      if (nextScroll >= maxScroll) {
        controller.animateTo(
          maxScroll,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        ).then((_) {
          // After reaching the end, wait 1 second then scroll back to start
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (controller.hasClients) {
              controller.animateTo(
                0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              );
            }
          });
        });
      } else {
        controller.animateTo(
          nextScroll,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  }

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(isDark),

            // Content
            Expanded(
              child: IndexedStack(
                index: _currentNavIndex,
                children: [
                  // Home Tab (index 0)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),

                        // Location selector
                        _buildLocationSelector(),
                        SizedBox(height: 24.h),

                        // Search bar
                        _buildSearchBar(),
                        SizedBox(height: 24.h),

                        // Filters
                        _buildFilters(),
                        SizedBox(height: 24.h),

                        // Date selector (horizontal scroll)
                        _buildDateSelector(),
                        SizedBox(height: 32.h),

                    // 1. Hot Shifts Section
                    SectionHeader(
                      title: 'Hot Shifts',
                      icon: Icons.local_fire_department_rounded,
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobsListScreen(
                              title: 'Hot Shifts',
                              icon: Icons.local_fire_department_rounded,
                              jobs: MockJobs.hotShifts,
                              isGuest: widget.isGuest,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildHorizontalJobList(MockJobs.hotShifts, _hotShiftsController),
                    SizedBox(height: 32.h),

                    // Banner
                    _buildBanner(),
                    SizedBox(height: 32.h),

                    // 2. AI Suggested Jobs Section
                    SectionHeader(
                      title: 'AI Suggested Jobs',
                      icon: Icons.auto_awesome_rounded,
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobsListScreen(
                              title: 'AI Suggested Jobs',
                              icon: Icons.auto_awesome_rounded,
                              jobs: MockJobs.aiSuggestedJobs,
                              isGuest: widget.isGuest,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildHorizontalJobList(MockJobs.aiSuggestedJobs, _aiSuggestedController),
                    SizedBox(height: 32.h),

                    // Category chips
                    CategoryChipsRow(
                      onCategorySelected: (category) {
                        // Handle category selection
                      },
                    ),
                    SizedBox(height: 32.h),

                    // 3. Nearby Jobs Section
                    SectionHeader(
                      title: 'Nearby Jobs',
                      icon: Icons.location_on_rounded,
                      subtitle: 'Jobs within 2 km',
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobsListScreen(
                              title: 'Nearby Jobs',
                              subtitle: 'Jobs within 2 km',
                              icon: Icons.location_on_rounded,
                              jobs: MockJobs.nearbyJobs,
                              isGuest: widget.isGuest,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildHorizontalJobList(MockJobs.nearbyJobs, _nearbyJobsController),
                    SizedBox(height: 32.h),

                    // 4. All Jobs Section
                    SectionHeader(
                      title: 'All Jobs',
                      icon: Icons.work_outline_rounded,
                      subtitle: '${MockJobs.allJobs.length} jobs',
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobsListScreen(
                              title: 'All Jobs',
                              subtitle: '${MockJobs.allJobs.length} jobs',
                              icon: Icons.work_outline_rounded,
                              jobs: MockJobs.allJobs,
                              isGuest: widget.isGuest,
                            ),
                          ),
                        );
                      },
                    ),
                        SizedBox(height: 16.h),
                        _buildHorizontalJobList(MockJobs.allJobs, _allJobsController),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                  // Jobs/Schedule Tab (index 1)
                  const MyScheduleScreen(),
                  // Wallet Tab (index 2)
                  const WalletScreen(),
                  // Profile Tab (index 3)
                  const ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GuestBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        onRestrictedTap: _handleRestrictedAccess,
        isGuest: widget.isGuest,
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkCard : ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: ColorManager.authGradient,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'DO',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s16.sp,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Jobs',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s20.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          const Spacer(),

          // Points (Silver 3,450)
          if (widget.isGuest)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.authSurface,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.stars_rounded,
                    size: 16.sp,
                    color: ColorManager.authPrimary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Silver',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.authPrimary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '3,450',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.bold,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(width: 12.w),

          // Notifications
          IconButton(
            onPressed: _handleRestrictedAccess,
            icon: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            size: 20.sp,
            color: ColorManager.authPrimary,
          ),
          SizedBox(width: 8.w),
          Text(
            _selectedLocation,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.semiBold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20.sp,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: ColorManager.textTertiary,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20.sp,
                    color: ColorManager.textTertiary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.bookmark_outline,
              size: 20.sp,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          _buildFilterChip('Filters', Icons.tune),
          SizedBox(width: 8.w),
          _buildFilterChip('Sort', Icons.sort),
          SizedBox(width: 8.w),
          _buildFilterChip('Distance', Icons.location_on_outlined),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorManager.grey4,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: ColorManager.textPrimary,
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s12.sp,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final dayAfterTomorrow = now.add(const Duration(days: 2));

    final dayAfterTomorrowName = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][dayAfterTomorrow.weekday % 7];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // All Dates
          Expanded(
            child: _buildDateChip(
              topText: 'All',
              bottomText: 'Dates',
              isSelected: true,
              onTap: () {},
            ),
          ),
          SizedBox(width: 10.w),

          // Today
          Expanded(
            child: _buildDateChip(
              topText: 'Today',
              bottomText: '${now.day}',
              isSelected: false,
              onTap: () {},
            ),
          ),
          SizedBox(width: 10.w),

          // Tomorrow
          Expanded(
            child: _buildDateChip(
              topText: 'Tomorrow',
              bottomText: '${tomorrow.day}',
              isSelected: false,
              onTap: () {},
            ),
          ),
          SizedBox(width: 10.w),

          // Day after tomorrow
          Expanded(
            child: _buildDateChip(
              topText: dayAfterTomorrowName,
              bottomText: '${dayAfterTomorrow.day}',
              isSelected: false,
              onTap: () {},
            ),
          ),
          SizedBox(width: 10.w),

          // Calendar icon
          GestureDetector(
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: now,
                lastDate: now.add(const Duration(days: 365)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: ColorManager.authPrimary,
                        onPrimary: ColorManager.white,
                        surface: ColorManager.white,
                        onSurface: ColorManager.textPrimary,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
            },
            child: Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                size: 20.sp,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip({
    required String topText,
    required String bottomText,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorManager.authGradient,
                )
              : null,
          color: isSelected ? null : ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              topText,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s10.sp,
                fontWeight: FontWeightManager.medium,
                color: isSelected
                    ? ColorManager.white
                    : ColorManager.textSecondary,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              bottomText,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.bold,
                color: isSelected
                    ? ColorManager.white
                    : ColorManager.textPrimary,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalJobList(List<JobModel> jobs, ScrollController controller) {
    return SizedBox(
      height: 270.h,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: jobs.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          return JobCard(
            job: jobs[index],
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
            onBookmark: widget.isGuest ? _handleRestrictedAccess : () {
              // Handle bookmark for logged-in users
            },
          );
        },
      ),
    );
  }

  Widget _buildBanner() {
    final banners = [
      {
        'title1': 'Upskill Today,',
        'title2': 'Get Hired Tomorrow!',
        'icon': Icons.rocket_launch_rounded,
        'colors': [const Color(0xFF0EA5E9), const Color(0xFF06B6D4)],
      },
      {
        'title1': 'Find Your Dream',
        'title2': 'Job Today!',
        'icon': Icons.work_rounded,
        'colors': [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
      },
      {
        'title1': 'Earn More,',
        'title2': 'Work Smarter!',
        'icon': Icons.trending_up_rounded,
        'colors': [const Color(0xFF10B981), const Color(0xFF059669)],
      },
    ];

    return SizedBox(
      height: 140.h,
      child: PageView.builder(
        controller: _bannerPageController,
        onPageChanged: (index) {
          setState(() {
            _currentBannerPage = index;
          });
        },
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: banner['colors'] as List<Color>,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: (banner['colors'] as List<Color>)[1].withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20.w,
                  bottom: -20.h,
                  child: Icon(
                    banner['icon'] as IconData,
                    size: 120.sp,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        banner['title1'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s20.sp,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                        ),
                      ),
                      Text(
                        banner['title2'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s20.sp,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Page indicators inside banner at bottom
                Positioned(
                  bottom: 16.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (indicatorIndex) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: _currentBannerPage == indicatorIndex ? 20.w : 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: _currentBannerPage == indicatorIndex
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
