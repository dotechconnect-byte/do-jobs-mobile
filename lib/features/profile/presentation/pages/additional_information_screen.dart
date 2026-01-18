import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/widgets/custom_button.dart';

class AdditionalInformationScreen extends StatefulWidget {
  const AdditionalInformationScreen({super.key});

  @override
  State<AdditionalInformationScreen> createState() => _AdditionalInformationScreenState();
}

class _AdditionalInformationScreenState extends State<AdditionalInformationScreen> {
  final List<String> _transportOptions = const [
    'Public Transportation',
    'Personal Car',
    'Motorcycle/Scooter',
    'Bicycle',
    'Walking',
  ];

  String _selectedTransport = 'Public Transportation';
  bool _hasLicense = true;
  bool _ownsVehicle = true;
  bool _willingToTravel = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textPrimary = isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary;
    final textSecondary = isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Additional Information',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s18.sp,
                  fontWeight: FontWeightManager.semiBold,
                  color: textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDark ? ColorManager.darkInput : ColorManager.grey6,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: isDark ? ColorManager.darkBorder : ColorManager.grey3),
              ),
              child: Text(
                'Optional',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s11.sp,
                  fontWeight: FontWeightManager.semiBold,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Other helpful details for employers',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s13.sp,
                fontWeight: FontWeightManager.regular,
                color: textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? ColorManager.darkCard : ColorManager.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: isDark ? ColorManager.darkBorder : ColorManager.authInputBorder),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: ColorManager.authPrimary.withValues(alpha: 0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    icon: Icons.commute_outlined,
                    title: 'Transportation & Commute',
                    isDark: isDark,
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Primary Transportation Method',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s13.sp,
                      fontWeight: FontWeightManager.medium,
                      color: textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildTransportDropdown(isDark, textPrimary, textSecondary),
                  SizedBox(height: 14.h),
                  _buildToggleRow(
                    label: 'I have a valid driving license',
                    value: _hasLicense,
                    isDark: isDark,
                    onChanged: (value) => setState(() => _hasLicense = value),
                  ),
                  SizedBox(height: 10.h),
                  _buildToggleRow(
                    label: 'I own a vehicle',
                    value: _ownsVehicle,
                    isDark: isDark,
                    onChanged: (value) => setState(() => _ownsVehicle = value),
                  ),
                  SizedBox(height: 10.h),
                  _buildToggleRow(
                    label: 'Willing to travel for work',
                    value: _willingToTravel,
                    isDark: isDark,
                    onChanged: (value) => setState(() => _willingToTravel = value),
                  ),
                  SizedBox(height: 20.h),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
                  ),
                  SizedBox(height: 16.h),
                  _buildSectionHeader(
                    icon: Icons.favorite_border_rounded,
                    title: 'Saved Jobs (Wishlist)',
                    isDark: isDark,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'View and manage jobs you\'ve saved for later',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.regular,
                      color: textSecondary,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _buildWishlistBar(isDark, textPrimary),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: 'Confirm',
              onPressed: _handleConfirm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorManager.authPrimary,
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.semiBold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
        ),
        Icon(
          Icons.keyboard_arrow_up_rounded,
          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
          size: 20.sp,
        ),
      ],
    );
  }

  Widget _buildTransportDropdown(bool isDark, Color textPrimary, Color textSecondary) {
    return DropdownButtonFormField<String>(
      initialValue: _selectedTransport,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: textSecondary,
      ),
      dropdownColor: isDark ? ColorManager.darkCard : ColorManager.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? ColorManager.darkInput : ColorManager.authInputBackground,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: isDark ? ColorManager.darkBorder : ColorManager.authInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorManager.authPrimary, width: 1.4),
        ),
      ),
      style: GoogleFonts.poppins(
        fontSize: FontSize.s13.sp,
        fontWeight: FontWeightManager.medium,
        color: textPrimary,
      ),
      items: _transportOptions
          .map(
            (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _selectedTransport = value;
        });
      },
    );
  }

  Widget _buildToggleRow({
    required String label,
    required bool value,
    required bool isDark,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(10.r),
      child: Row(
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: value ? ColorManager.authPrimary.withValues(alpha: 0.14) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: value ? ColorManager.authPrimary : (isDark ? ColorManager.darkBorder : ColorManager.grey3),
              ),
            ),
            child: value
                ? Icon(
                    Icons.check,
                    color: ColorManager.authPrimary,
                    size: 14.sp,
                  )
                : null,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s13.sp,
                fontWeight: FontWeightManager.medium,
                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistBar(bool isDark, Color textPrimary) {
    final Color borderColor = isDark ? ColorManager.darkBorder : ColorManager.authInputBorder;
    final Color surfaceColor = isDark ? ColorManager.darkInput : ColorManager.authSurface;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            color: ColorManager.authPrimary,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'View My Wishlist',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s13.sp,
              fontWeight: FontWeightManager.semiBold,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleConfirm() {
    Navigator.pop(context);
  }
}
