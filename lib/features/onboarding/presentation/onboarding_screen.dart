import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../../auth/presentation/auth_screen.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _onboardingPages = [
    const OnboardingModel(
      title: 'Track Your\nDOings',
      description: 'Keep tabs on all your gigs and shifts.\nNever miss a beat with real-time tracking.',
      gradientColors: ColorManager.trackingGradient,
      iconData: Icons.calendar_today_rounded,
      additionalInfo: '120 Hours • 8 Jobs This Week',
    ),
    const OnboardingModel(
      title: 'DO More.\nEarn More',
      description: 'Take on more gigs, maximize your earnings.\nYour wallet will thank you.',
      gradientColors: ColorManager.earningsGradient,
      iconData: Icons.account_balance_wallet_rounded,
      additionalInfo: '\$2,450 Earned This Month',
    ),
    const OnboardingModel(
      title: 'Stop Searching,\nStart Working',
      description: 'Find gigs that match your skills instantly.\nWork on your terms, your way.',
      gradientColors: ColorManager.jobsGradient,
      iconData: Icons.search_rounded,
      additionalInfo: '500+ Active Gigs Near You',
    ),
    const OnboardingModel(
      title: 'Welcome to\nDO',
      description: 'Your gateway to flexible work opportunities.\nLet\'s get started on your journey.',
      gradientColors: ColorManager.welcomeGradient,
      iconData: Icons.star_rounded,
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with onboarding screens
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _onboardingPages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                model: _onboardingPages[index],
                isActive: _currentPage == index,
              );
            },
          ),

          // Skip button (only show if not on last page)
          if (_currentPage < _onboardingPages.length - 1)
            Positioned(
              top: 48.h,
              right: 24.w,
              child: SafeArea(
                child: TextButton(
                  onPressed: _skipOnboarding,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: _currentPage == index ? 32.w : 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Next/Get Started button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _onboardingPages[_currentPage]
                              .gradientColors
                              .first,
                          elevation: 8,
                          shadowColor: Colors.black.withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage == _onboardingPages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s16.sp,
                                fontWeight: FontWeightManager.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              _currentPage == _onboardingPages.length - 1
                                  ? Icons.rocket_launch_rounded
                                  : Icons.arrow_forward_rounded,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
