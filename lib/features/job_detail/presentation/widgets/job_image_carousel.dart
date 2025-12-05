import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';

class JobImageCarousel extends StatefulWidget {
  final List<String> images;
  final String title;
  final String company;
  final String location;

  const JobImageCarousel({
    super.key,
    required this.images,
    required this.title,
    required this.company,
    required this.location,
  });

  @override
  State<JobImageCarousel> createState() => _JobImageCarouselState();
}

class _JobImageCarouselState extends State<JobImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              // Use color placeholders instead of images
              final colors = [
                const Color(0xFF6366F1), // Indigo
                const Color(0xFF3B82F6), // Blue
                const Color(0xFF8B5CF6), // Purple
              ];

              return Container(
                decoration: BoxDecoration(
                  color: colors[index % colors.length],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.warehouse_outlined,
                      size: 100.sp,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              );
            },
          ),

          // Job Info Overlay
          Positioned(
            bottom: 16.h,
            left: 20.w,
            right: 100.w, // Leave space for indicators
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.company,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.location,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.white.withValues(alpha: 0.9),
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Page Indicators at bottom right
          Positioned(
            bottom: 24.h,
            right: 20.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: _currentPage == index ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? ColorManager.white
                        : ColorManager.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
