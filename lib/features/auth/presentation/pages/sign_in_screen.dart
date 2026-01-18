import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../home/presentation/home_screen.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onGuestMode;

  const SignInScreen({
    super.key,
    required this.onGuestMode,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate authentication delay
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });

      // If validation passes, proceed to home screen
      // In a real app, this would call an authentication API
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_outline, color: ColorManager.white, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Sign in successful!',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s13.sp,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to home screen
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(isGuest: false),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Form(
      key: _formKey,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Field with enhanced styling
              _buildEnhancedTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter your email address',
                prefixIcon: Icons.email_outlined,
                isDark: isDark,
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 20.h),

              // Password Field with enhanced styling
              _buildEnhancedTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                isDark: isDark,
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 12.h),

              // Forgot password with hover effect
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.info_outline, color: ColorManager.white, size: 20.sp),
                            SizedBox(width: 12.w),
                            Text(
                              'Forgot password to be implemented',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s13.sp,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: ColorManager.authPrimary,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(16.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Forgot password?',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.authPrimary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16.sp,
                          color: ColorManager.authPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Enhanced Sign In Button with gradient
              _buildGradientButton(
                text: 'Sign In',
                onPressed: _handleSignIn,
                isLoading: _isLoading,
                isDark: isDark,
              ),
              SizedBox(height: 28.h),

              // Enhanced OR Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            isDark ? ColorManager.darkBorder : ColorManager.grey3,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: isDark
                            ? ColorManager.darkCard.withValues(alpha: 0.5)
                            : ColorManager.grey4.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
                        ),
                      ),
                      child: Text(
                        'OR',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            isDark ? ColorManager.darkBorder : ColorManager.grey3,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              // Enhanced Guest Mode Button
              _buildGuestModeButton(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixIcon,
    required bool isDark,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      controller: controller,
      label: label,
      hintText: hintText,
      prefixIcon: prefixIcon,
      isPassword: isPassword,
      validator: validator,
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    required bool isLoading,
    required bool isDark,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ColorManager.authGradient,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.authPrimary.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: ColorManager.white,
                        size: 20.sp,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestModeButton({required bool isDark}) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkCard : ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? ColorManager.authPrimary.withValues(alpha: 0.3)
              : ColorManager.authPrimary.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? ColorManager.authPrimary.withValues(alpha: 0.1)
                : ColorManager.authPrimary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onGuestMode,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorManager.authGradient,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: ColorManager.white,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Continue as Guest',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s15.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
