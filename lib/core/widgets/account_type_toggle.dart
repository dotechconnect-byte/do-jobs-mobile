import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/color_manager.dart';
import '../consts/font_manager.dart';

enum AccountType { personal, services }

class AccountTypeToggle extends StatelessWidget {
  final AccountType selectedType;
  final Function(AccountType) onChanged;

  const AccountTypeToggle({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: ColorManager.authSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              type: AccountType.personal,
              label: 'Personal',
              icon: Icons.person_outline_rounded,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: _buildToggleButton(
              type: AccountType.services,
              label: 'Services',
              icon: Icons.business_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required AccountType type,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => onChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.authPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManager.authPrimary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: isSelected
                    ? ColorManager.white
                    : ColorManager.authSecondaryText,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: isSelected
                      ? FontWeightManager.semiBold
                      : FontWeightManager.medium,
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.authSecondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
