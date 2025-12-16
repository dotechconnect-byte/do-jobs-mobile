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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
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
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
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
                  color: ColorManager.textPrimary,
                ),
              ),
              Text(
                '${_focusedMonth.year}',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.textSecondary,
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
    final daysInMonth = _getDaysInMonth(_focusedMonth);
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.05),
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
    final isSelected = _selectedDay != null && _isSameDay(date, _selectedDay!);

    // If there's a scheduled job, show it in an indigo card
    if (hasScheduled && scheduledEvent != null) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedDay = date;
          });
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

    // Regular date cell
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
        height: 90.h,
        margin: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          gradient: hasAvailability
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF10B981).withValues(alpha: 0.15),
                    const Color(0xFF059669).withValues(alpha: 0.1),
                  ],
                )
              : isToday
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorManager.authPrimary.withValues(alpha: 0.15),
                        ColorManager.authPrimary.withValues(alpha: 0.08),
                      ],
                    )
                  : null,
          color: hasAvailability || isToday ? null : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: hasAvailability
                ? const Color(0xFF10B981)
                : isToday
                    ? ColorManager.authPrimary
                    : const Color(0xFFE5E7EB),
            width: hasAvailability || isToday ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManager.authPrimary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$dayNumber',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s16.sp,
                      fontWeight: isToday || hasAvailability
                          ? FontWeightManager.bold
                          : FontWeightManager.semiBold,
                      color: isToday
                          ? ColorManager.authPrimary
                          : hasAvailability
                              ? const Color(0xFF059669)
                              : ColorManager.textPrimary,
                    ),
                  ),
                  if (hasAvailability)
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12.sp,
                        color: ColorManager.white,
                      ),
                    ),
                ],
              ),
              if (isToday && !hasAvailability)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: ColorManager.authPrimary,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'Today',
                      style: GoogleFonts.poppins(
                        fontSize: 8.sp,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFAFAFA),
            const Color(0xFFF5F3FF),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
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
                  color: ColorManager.textPrimary,
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
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isOutline ? ColorManager.white : color,
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
              color: ColorManager.textPrimary,
            ),
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
