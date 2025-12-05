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
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final availabilityCount = MockCalendarEvents.getAvailabilityCount();

    return Scaffold(
      backgroundColor: ColorManager.authBackground,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20.sp,
            color: ColorManager.textPrimary,
          ),
        ),
        title: Text(
          'My Calendar',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // Month/Year header
            _buildMonthHeader(),

            SizedBox(height: 16.h),

            // Availability banner
            if (availabilityCount > 0) _buildAvailabilityBanner(),

            // Calendar
            _buildCalendar(),

            SizedBox(height: 24.h),

            // Legend
            _buildLegend(),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s24.sp,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          Row(
            children: [
              IconButton(
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
                  size: 28.sp,
                  color: ColorManager.textPrimary,
                ),
              ),
              IconButton(
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
                  size: 28.sp,
                  color: ColorManager.textPrimary,
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
    final daysInMonth = _getDaysInMonth(_focusedMonth);
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
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
                    return Expanded(child: SizedBox(height: 48.h));
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

    final isToday = _isSameDay(date, DateTime.now());
    final isSelected = _selectedDay != null && _isSameDay(date, _selectedDay!);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = date;
        });
        if (events.isEmpty) {
          _showMarkAvailabilityDialog(date);
        } else {
          _showDayEventsDialog(date);
        }
      },
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ColorManager.authGradient,
                )
              : null,
          color: isSelected
              ? null
              : isToday
                  ? ColorManager.authPrimary.withValues(alpha: 0.1)
                  : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                '$dayNumber',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: isSelected || isToday
                      ? FontWeightManager.bold
                      : FontWeightManager.medium,
                  color: isSelected
                      ? ColorManager.white
                      : isToday
                          ? ColorManager.authPrimary
                          : ColorManager.textPrimary,
                ),
              ),
            ),
            if (hasScheduled || hasAvailability)
              Positioned(
                bottom: 6.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: hasScheduled
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calendar Legend',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildLegendItem(
            color: const Color(0xFF3B82F6),
            label: 'Upcoming Job Scheduled',
          ),
          SizedBox(height: 12.h),
          _buildLegendItem(
            color: const Color(0xFF10B981),
            label: 'Availability Marked',
          ),
          SizedBox(height: 12.h),
          _buildLegendItem(
            color: ColorManager.grey4,
            label: 'Click to Mark Available',
            isOutline: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    bool isOutline = false,
  }) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: isOutline ? ColorManager.white : color,
            border: isOutline ? Border.all(color: color, width: 2) : null,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  void _showDayEventsDialog(DateTime date) {
    final events = MockCalendarEvents.getEventsForDate(date);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          '${_getMonthAbbr(date.month)} ${date.day}, ${date.year}',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
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
                    ? const Color(0xFFDEEBFF)
                    : const Color(0xFFD1FAE5),
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
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    event.timeRange,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s12.sp,
                      fontWeight: FontWeightManager.regular,
                      color: ColorManager.textSecondary,
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
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Mark Availability',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Text(
          'Would you like to mark yourself as available on ${_getMonthAbbr(date.month)} ${date.day}, ${date.year}?',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Availability marked for ${_getMonthAbbr(date.month)} ${date.day}',
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
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Mark Available',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
        ],
      ),
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
