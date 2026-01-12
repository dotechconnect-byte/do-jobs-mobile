import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../data/mock_calendar_events.dart';

class CalendarViewScreen extends StatefulWidget {
  const CalendarViewScreen({super.key});

  @override
  State<CalendarViewScreen> createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  DateTime _focusedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final availabilityCount = MockCalendarEvents.getAvailabilityCount();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.authBackground,
      appBar: AppBar(
        backgroundColor: isDark ? ColorManager.darkSurface : ColorManager.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20.sp,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        title: Text(
          'My Calendar',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.bold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    ColorManager.darkSurface,
                    ColorManager.darkBackground,
                  ]
                : [
                    ColorManager.white,
                    ColorManager.authBackground,
                  ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8.h),

              // Month/Year header
              _buildMonthHeader(),

              SizedBox(height: 16.h),

              // Availability banner
              if (availabilityCount > 0) _buildAvailabilityBanner(),

              SizedBox(height: 8.h),

              // Calendar
              _buildCalendar(),

              SizedBox(height: 20.h),

              // Legend
              _buildLegend(),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.authPrimary.withValues(alpha: 0.15),
                  ColorManager.authPrimaryDark.withValues(alpha: 0.1),
                ],
              )
            : null,
        color: isDark ? null : ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: isDark
            ? Border.all(
                color: ColorManager.authPrimary.withValues(alpha: 0.3),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: isDark ? 0.2 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthNames[_focusedMonth.month - 1],
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s22.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
              Text(
                '${_focusedMonth.year}',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.medium,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.authPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(
                        _focusedMonth.year,
                        _focusedMonth.month - 1,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    size: 24.sp,
                    color: ColorManager.authPrimary,
                  ),
                  padding: EdgeInsets.all(8.w),
                  constraints: const BoxConstraints(),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: ColorManager.authGradient,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(
                        _focusedMonth.year,
                        _focusedMonth.month + 1,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.chevron_right_rounded,
                    size: 24.sp,
                    color: ColorManager.white,
                  ),
                  padding: EdgeInsets.all(8.w),
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityBanner() {
    final availabilityCount = MockCalendarEvents.getAvailabilityCount();
    final availabilityDates = MockCalendarEvents.getAvailabilityDates();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD1FAE5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 20.sp,
                color: const Color(0xFF10B981),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'You have marked your availability for $availabilityCount days',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s13.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: const Color(0xFF065F46),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              ...availabilityDates.take(3).map((date) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${_getMonthAbbr(date.month)} ${date.day}, ${date.year} (9h)',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s11.sp,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.white,
                    ),
                  ),
                );
              }),
              if (availabilityDates.length > 3)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFF10B981),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '+${availabilityDates.length - 3} more',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s11.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final daysInMonth = _getDaysInMonth(_focusedMonth);
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.authPrimary.withValues(alpha: 0.15),
                  ColorManager.authPrimaryDark.withValues(alpha: 0.1),
                ],
              )
            : null,
        color: isDark ? null : ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isDark
            ? Border.all(
                color: ColorManager.authPrimary.withValues(alpha: 0.3),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: isDark ? 0.1 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Day headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s12.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: const Color(0xFF8B5CF6),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 12.h),

          // Calendar grid
          ...List.generate((daysInMonth + firstWeekday + 6) ~/ 7, (weekIndex) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: List.generate(7, (dayIndex) {
                  final dayNumber =
                      weekIndex * 7 + dayIndex - firstWeekday + 1;

                  if (dayNumber < 1 || dayNumber > daysInMonth) {
                    return Expanded(child: SizedBox(height: 90.h));
                  }

                  final date = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month,
                    dayNumber,
                  );

                  return Expanded(
                    child: _buildDayCell(date, dayNumber),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDayCell(DateTime date, int dayNumber) {
    final events = MockCalendarEvents.getEventsForDate(date);
    final hasScheduled =
        events.any((event) => event.type == 'scheduled');
    final hasAvailability =
        events.any((event) => event.type == 'available');
    final scheduledEvent = hasScheduled
        ? events.firstWhere((event) => event.type == 'scheduled')
        : null;

    final isToday = _isSameDay(date, DateTime.now());

    // If there's a scheduled job, show it in an indigo card
    if (hasScheduled && scheduledEvent != null) {
      return GestureDetector(
        onTap: () {
          _showDayEventsDialog(date);
        },
        child: Container(
          height: 90.h,
          margin: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6366F1),
                Color(0xFF4F46E5),
              ],
            ),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative circle
              Positioned(
                top: -10,
                right: -10,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day number with badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorManager.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '$dayNumber',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s16.sp,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.work_rounded,
                          size: 16.sp,
                          color: ColorManager.white.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Job details
                    Text(
                      scheduledEvent.title,
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s11.sp,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.white,
                        letterSpacing: 0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 10.sp,
                          color: ColorManager.white.withValues(alpha: 0.9),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            scheduledEvent.timeRange,
                            style: GoogleFonts.poppins(
                              fontSize: 9.sp,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.white.withValues(alpha: 0.95),
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Available day cell (matches web design)
    if (hasAvailability) {
      return GestureDetector(
        onTap: () {
          _showDayEventsDialog(date);
        },
        child: Container(
          height: 90.h,
          margin: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Day number
                Text(
                  '$dayNumber',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s22.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(height: 6.h),
                // Dots indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 4.w,
                      height: 4.w,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                // Hours available
                Text(
                  '7h available',
                  style: GoogleFonts.poppins(
                    fontSize: 9.sp,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Regular date cell
    final isDarkCell = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (events.isEmpty) {
          _showMarkAvailabilityDialog(date);
        } else {
          _showDayEventsDialog(date);
        }
      },
      child: Container(
        height: 90.h,
        margin: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isToday
              ? ColorManager.authPrimary.withValues(alpha: 0.1)
              : (isDarkCell ? ColorManager.darkInput : const Color(0xFFF5F3FF)),
          borderRadius: BorderRadius.circular(12.r),
          border: isToday
              ? Border.all(
                  color: ColorManager.authPrimary,
                  width: 2,
                )
              : null,
        ),
        child: Center(
          child: Text(
            '$dayNumber',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s18.sp,
              fontWeight: isToday
                  ? FontWeightManager.bold
                  : FontWeightManager.semiBold,
              color: isToday
                  ? ColorManager.authPrimary
                  : (isDarkCell ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  ColorManager.authPrimary.withValues(alpha: 0.15),
                  ColorManager.authPrimaryDark.withValues(alpha: 0.1),
                ]
              : [
                  const Color(0xFFFAFAFA),
                  const Color(0xFFF5F3FF),
                ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: isDark ? 0.3 : 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: ColorManager.authGradient,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 18.sp,
                  color: ColorManager.white,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Calendar Legend',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s16.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildLegendItem(
            color: const Color(0xFF3B82F6),
            label: 'Upcoming Job Scheduled',
            icon: Icons.work_outline_rounded,
          ),
          SizedBox(height: 12.h),
          _buildLegendItem(
            color: const Color(0xFF10B981),
            label: 'Availability Marked',
            icon: Icons.check_circle_outline_rounded,
          ),
          SizedBox(height: 12.h),
          _buildLegendItem(
            color: const Color(0xFFE5E7EB),
            label: 'Click to Mark Available',
            isOutline: true,
            icon: Icons.touch_app_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required IconData icon,
    bool isOutline = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isOutline
                ? (isDark ? ColorManager.darkInput : ColorManager.white)
                : color,
            border: isOutline ? Border.all(color: color, width: 2) : null,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: isOutline ? color : ColorManager.white,
          ),
        ),
        SizedBox(width: 12.w),
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
    );
  }

  void _showDayEventsDialog(DateTime date) {
    final events = MockCalendarEvents.getEventsForDate(date);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          '${_getMonthAbbr(date.month)} ${date.day}, ${date.year}',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.bold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: events.map((event) {
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: event.isScheduled
                    ? (isDark
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                        : const Color(0xFFDEEBFF))
                    : (isDark
                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                        : const Color(0xFFD1FAE5)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    event.timeRange,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.regular,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.authPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMarkAvailabilityDialog(DateTime date) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SetAvailabilityDialog(date: date),
    );
  }

  int _getDaysInMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

// Set Availability Dialog Widget
class _SetAvailabilityDialog extends StatefulWidget {
  final DateTime date;

  const _SetAvailabilityDialog({required this.date});

  @override
  State<_SetAvailabilityDialog> createState() => _SetAvailabilityDialogState();
}

class _SetAvailabilityDialogState extends State<_SetAvailabilityDialog> {
  final Set<String> _selectedShifts = {};

  final List<Map<String, String>> _shifts = [
    {'name': 'Early Morning Shift', 'time': '6 AM - 5 PM'},
    {'name': 'Morning Shift', 'time': '10 AM - 6 PM'},
    {'name': 'Evening Shift', 'time': '5 PM - 12 AM (next day)'},
    {'name': 'Late Night Shift', 'time': '5 PM - 4 AM'},
    {'name': 'Full Day', 'time': '12 AM - 12 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? ColorManager.darkSurface : ColorManager.white;
    final textColor = isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary;
    final secondaryTextColor = isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary;

    return Dialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: 550.h),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set Availability',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s18.sp,
                              fontWeight: FontWeightManager.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Select preset shifts or individual hours for ${_getMonthName(widget.date.month)} ${widget.date.day}, ${widget.date.year}',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s11.sp,
                              fontWeight: FontWeightManager.regular,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: secondaryTextColor),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                SizedBox(height: 18.h),

                // Quick Select Shifts Section
                Text(
                  'Quick Select Shifts (click multiple to combine)',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s11.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.authPrimary,
                  ),
                ),

                SizedBox(height: 10.h),

                // Shift Buttons in Grid
                ...List.generate((_shifts.length / 2).ceil(), (rowIndex) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildShiftButton(
                            _shifts[rowIndex * 2],
                            isDark,
                            textColor,
                            secondaryTextColor,
                          ),
                        ),
                        if (rowIndex * 2 + 1 < _shifts.length) ...[
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _buildShiftButton(
                              _shifts[rowIndex * 2 + 1],
                              isDark,
                              textColor,
                              secondaryTextColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),

                SizedBox(height: 16.h),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Availability marked successfully!',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s14.sp,
                              fontWeight: FontWeightManager.medium,
                            ),
                          ),
                          backgroundColor: const Color(0xFF10B981),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.authPrimary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Confirm',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s16.sp,
                            fontWeight: FontWeightManager.semiBold,
                          ),
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
    );
  }

  Widget _buildShiftButton(
    Map<String, String> shift,
    bool isDark,
    Color textColor,
    Color secondaryTextColor,
  ) {
    final isSelected = _selectedShifts.contains(shift['name']);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedShifts.remove(shift['name']);
          } else {
            _selectedShifts.add(shift['name']!);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.authPrimary.withValues(alpha: 0.1)
              : (isDark ? ColorManager.darkInput : const Color(0xFFF5F3FF)),
          border: Border.all(
            color: isSelected
                ? ColorManager.authPrimary
                : (isDark ? ColorManager.darkBorder : const Color(0xFFE9D5FF)),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              shift['name']!,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeightManager.semiBold,
                color: isSelected ? ColorManager.authPrimary : textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              shift['time']!,
              style: GoogleFonts.poppins(
                fontSize: FontSize.s10.sp,
                fontWeight: FontWeightManager.regular,
                color: secondaryTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
