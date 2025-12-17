import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../models/job_detail_model.dart';
import '../widgets/apply_bottom_bar.dart';
import '../widgets/benefits_section.dart';
import '../widgets/employer_info_card.dart';
import '../widgets/job_image_carousel.dart';
import '../widgets/location_card.dart';
import '../widgets/package_breakdown_card.dart';
import '../widgets/requirements_section.dart';
import '../widgets/salary_info_card.dart';

class JobDetailScreen extends StatefulWidget {
  final JobDetailModel job;

  const JobDetailScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isSaved = false;
  bool _showScrollButton = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    _isSaved = widget.job.isSaved;

    _scrollController.addListener(() {
      final isAtBottom = _scrollController.offset >=
          _scrollController.position.maxScrollExtent - 100;
      if (isAtBottom && _showScrollButton) {
        setState(() => _showScrollButton = false);
      } else if (!isAtBottom && !_showScrollButton) {
        setState(() => _showScrollButton = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar with Image Carousel
              SliverAppBar(
                expandedHeight: 280.h,
                pinned: true,
                backgroundColor: ColorManager.white,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
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
                      Icons.arrow_back,
                      size: 20.sp,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ),
                actions: [
                  _buildActionButton(
                    Icons.star_outline,
                    () {},
                  ),
                  _buildActionButton(
                    Icons.info_outline,
                    () {},
                  ),
                  _buildActionButton(
                    _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                    () {
                      setState(() {
                        _isSaved = !_isSaved;
                      });
                    },
                  ),
                  _buildActionButton(
                    Icons.notifications_outlined,
                    () {},
                  ),
                  SizedBox(width: 8.w),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: JobImageCarousel(
                    images: widget.job.images,
                    title: widget.job.title,
                    company: widget.job.company,
                    location: widget.job.location,
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Salary and Employment Type Cards
                      Row(
                        children: [
                          Expanded(
                            child: SalaryInfoCard(
                              icon: Icons.attach_money,
                              label: 'Annual Salary',
                              value: '\$${widget.job.annualSalary.toStringAsFixed(0)}/year',
                              iconColor: const Color(0xFF10B981),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: SalaryInfoCard(
                              icon: Icons.work_outline,
                              label: 'Employment Type',
                              value: widget.job.employmentType,
                              iconColor: ColorManager.authPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Package Breakdown Card
                      PackageBreakdownCard(
                        monthlySalary: widget.job.monthlySalary,
                        annualPackage: widget.job.annualSalary,
                        monthlyBenefits: widget.job.monthlyBenefits,
                        totalPackage: widget.job.totalPackage,
                      ),
                      SizedBox(height: 16.h),

                      // Location Card
                      LocationCard(
                        location: widget.job.address,
                        onOpenMaps: () {
                          // TODO: Open maps
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Tab Bar
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.grey6,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          labelColor: ColorManager.textPrimary,
                          unselectedLabelColor: ColorManager.textSecondary,
                          labelStyle: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                          unselectedLabelStyle: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.regular,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'Description'),
                            Tab(text: 'About Employer'),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Tab Content
                      SizedBox(
                        height: 800.h, // Adjust based on content
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Description Tab
                            _buildDescriptionTab(),
                            // About Employer Tab
                            _buildEmployerTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Apply Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ApplyBottomBar(
              packageAmount: '\$${widget.job.totalPackage.toStringAsFixed(0)}/year',
              onApply: () {
                // TODO: Handle apply
              },
              onShare: () {
                // TODO: Handle share
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: ColorManager.white,
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
            icon,
            size: 20.sp,
            color: ColorManager.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About the Role
          Text(
            'About the Role',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.job.jobDescription,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),

          // Requirements
          RequirementsSection(
            requirements: widget.job.requirements,
          ),
          SizedBox(height: 100.h), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildEmployerTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Employer Info Card
          EmployerInfoCard(
            companyName: widget.job.company,
            location: widget.job.location,
            isVerified: widget.job.isVerified,
            employeeCount: widget.job.employeeCount,
            openRoles: widget.job.openRoles,
            rating: widget.job.rating,
            aboutCompany: widget.job.aboutCompany,
          ),
          SizedBox(height: 16.h),

          // Benefits Section
          BenefitsSection(
            benefits: widget.job.benefits,
          ),
          SizedBox(height: 100.h), // Space for bottom bar
        ],
      ),
    );
  }
}
