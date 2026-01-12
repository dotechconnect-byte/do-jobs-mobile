import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../home/presentation/home_screen.dart';
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(isGuest: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorManager.authPrimary.withValues(alpha: 0.05),
              ColorManager.white,
              ColorManager.authAccent.withValues(alpha: 0.03),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern Header with Logo/Icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                child: Column(
                  children: [
                    // Logo/Icon Container
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
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.authPrimary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.work_rounded,
                        size: 40.sp,
                        color: ColorManager.white,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Welcome to DO',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s32.sp,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.textPrimary,
                        letterSpacing: -1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Your gateway to flexible work opportunities',
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

              // Modern Tab Bar with elevation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: ColorManager.authGradient,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.authPrimary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: ColorManager.white,
                    unselectedLabelColor: ColorManager.textSecondary,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.semiBold,
                      letterSpacing: 0.3,
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
              SizedBox(height: 32.h),

              // Tab Bar View - Expanded to fill remaining space
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Sign In Tab
                    SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
                      child: SignInScreen(
                        onBiometricLogin: _handleBiometricLogin,
                        onGuestMode: _handleGuestMode,
                      ),
                    ),

                    // Sign Up Tab
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
      ),
    );
  }
}
