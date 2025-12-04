import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 28.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s10.sp,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChipsRow extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryChipsRow({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'label': 'F&B', 'icon': Icons.restaurant, 'color': const Color(0xFFFF6B35)},
      {'label': 'Retail', 'icon': Icons.shopping_bag, 'color': const Color(0xFF00B4D8)},
      {'label': 'Logistics', 'icon': Icons.local_shipping, 'color': const Color(0xFFE83283)},
      {'label': 'Full Time', 'icon': Icons.business_center, 'color': const Color(0xFF10B981)},
      {'label': 'Blogs', 'icon': Icons.article, 'color': const Color(0xFF8B5CF6)},
      {'label': 'Employer', 'icon': Icons.badge, 'color': const Color(0xFFF59E0B)},
      {'label': 'Personal', 'icon': Icons.favorite, 'color': const Color(0xFFFF4E88)},
      {'label': 'Saved', 'icon': Icons.bookmark, 'color': const Color(0xFFEF4444)},
      {'label': 'Subscribe', 'icon': Icons.notifications, 'color': const Color(0xFF06B6D4)},
      {'label': 'Regular', 'icon': Icons.schedule, 'color': const Color(0xFF8B5CF6)},
    ];

    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            label: category['label'] as String,
            icon: category['icon'] as IconData,
            color: category['color'] as Color,
            onTap: () => onCategorySelected(category['label'] as String),
          );
        },
      ),
    );
  }
}
