import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
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

  void _handleBiometricLogin() {
    // TODO: Implement biometric login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Biometric login to be implemented',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
          ),
        ),
        backgroundColor: ColorManager.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _handleGuestMode() {
    // TODO: Navigate to guest mode
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Guest mode navigation to be implemented',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
          ),
        ),
        backgroundColor: ColorManager.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.authBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Welcome Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s28.sp,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Sign in to your account or create a new one',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s14.sp,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Tab Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: ColorManager.authSecondary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.all(4.w),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: ColorManager.textPrimary,
                  unselectedLabelColor: ColorManager.authSecondaryText,
                  labelStyle: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    fontWeight: FontWeightManager.medium,
                  ),
                  tabs: const [
                    Tab(text: 'Sign In'),
                    Tab(text: 'Sign Up'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Tab Bar View - Expanded to fill remaining space
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Sign In Tab - Wrapped in SingleChildScrollView
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
                    child: SignInScreen(
                      onBiometricLogin: _handleBiometricLogin,
                      onGuestMode: _handleGuestMode,
                    ),
                  ),

                  // Sign Up Tab - Wrapped in SingleChildScrollView
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
                    child: SignUpScreen(
                      onGuestMode: _handleGuestMode,
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
}
