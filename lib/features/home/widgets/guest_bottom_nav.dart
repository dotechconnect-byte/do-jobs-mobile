import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';

class GuestBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onRestrictedTap;
  final bool isGuest;

  const GuestBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onRestrictedTap,
    this.isGuest = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
                isRestricted: false,
              ),
              _buildNavItem(
                icon: Icons.work_outline_rounded,
                label: 'Jobs',
                index: 1,
                isActive: currentIndex == 1,
                onTap: isGuest ? onRestrictedTap : () => onTap(1),
                isRestricted: isGuest,
              ),
              _buildNavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Chat',
                index: 2,
                isActive: currentIndex == 2,
                onTap: isGuest ? onRestrictedTap : () => onTap(2),
                isRestricted: isGuest,
              ),
              _buildNavItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Wallet',
                index: 3,
                isActive: currentIndex == 3,
                onTap: isGuest ? onRestrictedTap : () => onTap(3),
                isRestricted: isGuest,
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                index: 4,
                isActive: currentIndex == 4,
                onTap: isGuest ? onRestrictedTap : () => onTap(4),
                isRestricted: isGuest,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
    required VoidCallback onTap,
    required bool isRestricted,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: ColorManager.authGradient,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 24.sp,
                  color: isActive
                      ? ColorManager.white
                      : ColorManager.textTertiary,
                ),
                SizedBox(height: 4.h),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s10.sp,
                    fontWeight: isActive
                        ? FontWeightManager.semiBold
                        : FontWeightManager.regular,
                    color: isActive
                        ? ColorManager.white
                        : ColorManager.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          // Lock icon for restricted items
          if (isRestricted)
            Positioned(
              top: -4.h,
              right: -4.w,
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: ColorManager.warning,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.white,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.lock,
                  size: 10.sp,
                  color: ColorManager.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
