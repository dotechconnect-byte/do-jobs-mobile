import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/account_type_toggle.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onGuestMode;

  const SignUpScreen({
    super.key,
    required this.onGuestMode,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _accessCodeController = TextEditingController();

  AccountType _accountType = AccountType.personal;
  bool _showAccessCode = false;
  bool _agreeToTerms = false;
  bool _isLoading = false;
  bool _isValidatingCode = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _accessCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleValidateAccessCode() async {
    if (_accessCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter an access code',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.medium,
            ),
          ),
          backgroundColor: ColorManager.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isValidatingCode = true;
    });

    // TODO: Implement actual access code validation
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isValidatingCode = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Access code validated successfully!',
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

  Future<void> _handleSignUp() async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please agree to Terms & Conditions',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.medium,
            ),
          ),
          backgroundColor: ColorManager.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Implement actual sign up logic
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account created successfully! Navigation to be implemented.',
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
          // Account Type Label
          Text(
            'Account Type',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.semiBold,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),

          // Account Type Toggle
          AccountTypeToggle(
            selectedType: _accountType,
            onChanged: (type) {
              setState(() {
                _accountType = type;
              });
            },
          ),
          SizedBox(height: 20.h),

          // Full Name or Company Name with smooth transition
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _accountType == AccountType.personal
                ? CustomTextField(
                    key: const ValueKey('personal'),
                    controller: _fullNameController,
                    label: 'Full Name',
                    hintText: 'John Doe',
                    prefixIcon: Icons.person_outline,
                    validator: Validators.validateFullName,
                  )
                : CustomTextField(
                    key: const ValueKey('services'),
                    controller: _companyNameController,
                    label: 'Company Name',
                    hintText: 'Acme Services Pte Ltd',
                    prefixIcon: Icons.business_outlined,
                    validator: Validators.validateCompanyName,
                  ),
          ),
          SizedBox(height: 20.h),

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

          // Phone Field
          CustomTextField(
            controller: _phoneController,
            label: 'Phone Number',
            hintText: '+65 9123 4567',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          SizedBox(height: 20.h),

          // Password Field
          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Create a strong password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: 20.h),

          // Confirm Password Field
          CustomTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: 'Re-enter your password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: (value) => Validators.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
          ),
          SizedBox(height: 16.h),

          // Access Code Expandable
          GestureDetector(
            onTap: () {
              setState(() {
                _showAccessCode = !_showAccessCode;
              });
            },
            child: Row(
              children: [
                AnimatedRotation(
                  turns: _showAccessCode ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.sp,
                    color: ColorManager.authPrimary,
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    _accountType == AccountType.personal
                        ? 'Have a referral code?'
                        : 'Have an access code?',
                    key: ValueKey(_accountType),
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.authPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_showAccessCode) ...[
            SizedBox(height: 16.h),
            CustomTextField(
              controller: _accessCodeController,
              label: _accountType == AccountType.personal
                  ? 'Referral Code'
                  : 'Access Code',
              hintText: _accountType == AccountType.personal
                  ? 'Enter referral code (optional)'
                  : 'Enter access code',
              prefixIcon: Icons.confirmation_number_outlined,
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: 'Validate Code',
              onPressed: _handleValidateAccessCode,
              isLoading: _isValidatingCode,
              type: ButtonType.outline,
            ),
            if (_accountType == AccountType.services) ...[
              SizedBox(height: 8.h),
              Text(
                'Access codes are provided by DO Jobs for quick registration. Test code: SERVICE2024',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s10.sp,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.textTertiary,
                  height: 1.4,
                ),
              ),
            ],
          ],
          SizedBox(height: 16.h),

          // Terms & Conditions Checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Checkbox(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  activeColor: ColorManager.authPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'I agree to the ',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.authPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.authPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Create Account Button
          CustomButton(
            text: 'Create Account',
            onPressed: _handleSignUp,
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
