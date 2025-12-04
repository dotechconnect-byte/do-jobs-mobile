import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onBiometricLogin;
  final VoidCallback onGuestMode;

  const SignInScreen({
    super.key,
    required this.onBiometricLogin,
    required this.onGuestMode,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Implement actual sign in logic
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign in successful! Navigation to be implemented.',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.medium,
              ),
            ),
            backgroundColor: ColorManager.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Field
          CustomTextField(
            controller: _emailController,
            label: 'Email Address',
            hintText: 'you@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          SizedBox(height: 20.h),

          // Password Field
          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: 8.h),

          // Forgot password - Right aligned
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to forgot password
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Forgot password to be implemented',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s14.sp,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot password?',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.authPrimary,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Sign In Button
          CustomButton(
            text: 'Sign In',
            onPressed: _handleSignIn,
            isLoading: _isLoading,
          ),
          SizedBox(height: 24.h),

          // OR Divider
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: ColorManager.grey3,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'OR CONTINUE WITH',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.textTertiary,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: ColorManager.grey3,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Biometric Login Button
          CustomButton(
            text: 'Biometric Login',
            onPressed: widget.onBiometricLogin,
            type: ButtonType.outline,
            icon: Icons.fingerprint_rounded,
          ),
          SizedBox(height: 24.h),

          // OR Divider
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: ColorManager.grey3,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'OR',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.textTertiary,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: ColorManager.grey3,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Guest Mode Button
          CustomButton(
            text: 'Guest Mode',
            onPressed: widget.onGuestMode,
            type: ButtonType.secondary,
            icon: Icons.person_outline_rounded,
          ),
        ],
      ),
    );
  }
}
