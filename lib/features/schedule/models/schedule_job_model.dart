class ScheduleJobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double hourlyRate;
  final String status; // 'upcoming' or 'completed'
  final bool isScannedIn;

  ScheduleJobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.hourlyRate,
    required this.status,
    this.isScannedIn = false,
  });

  // Calculate total earnings for the shift
  double get totalEarnings {
    // Parse time strings to calculate hours
    final start = _parseTime(startTime);
    final end = _parseTime(endTime);

    double hours;
    if (end < start) {
      // If end time is before start time, it means it goes past midnight
      hours = (24 - start + end);
    } else {
      hours = end - start;
    }

    return hours * hourlyRate;
  }

  double _parseTime(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    var hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final isPM = parts[1].toUpperCase() == 'PM';

    if (isPM && hour != 12) {
      hour += 12;
    } else if (!isPM && hour == 12) {
      hour = 0;
    }

    return hour + (minute / 60.0);
  }

  // Format date for display
  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // Check if job is today
  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final jobDate = DateTime(date.year, date.month, date.day);
    return jobDate == today;
  }

  // Check if job is tomorrow
  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    final jobDate = DateTime(date.year, date.month, date.day);
    return jobDate == tomorrow;
  }
}
