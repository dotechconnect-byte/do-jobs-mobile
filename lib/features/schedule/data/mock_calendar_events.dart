import '../models/calendar_event_model.dart';

class MockCalendarEvents {
  static final List<CalendarEventModel> events = [
    // Scheduled jobs (blue)
    CalendarEventModel(
      id: '1',
      title: 'Promoter',
      date: DateTime(2025, 12, 2),
      startTime: '10:00 AM',
      endTime: '06:00 PM',
      type: 'scheduled',
    ),
    CalendarEventModel(
      id: '2',
      title: 'Cleaning Staff',
      date: DateTime(2025, 12, 5),
      startTime: '06:00 AM',
      endTime: '02:00 PM',
      type: 'scheduled',
    ),
    CalendarEventModel(
      id: '3',
      title: 'Security Guard',
      date: DateTime(2025, 12, 8),
      startTime: '08:00 PM',
      endTime: '08:00 AM',
      type: 'scheduled',
    ),
    CalendarEventModel(
      id: '4',
      title: 'Event Coordinator',
      date: DateTime(2025, 12, 12),
      startTime: '02:00 PM',
      endTime: '10:00 PM',
      type: 'scheduled',
    ),

    // Availability marked (green)
    CalendarEventModel(
      id: '5',
      title: 'Available',
      date: DateTime(2025, 11, 10),
      startTime: '09:00 AM',
      endTime: '05:00 PM',
      type: 'available',
    ),
    CalendarEventModel(
      id: '6',
      title: 'Available',
      date: DateTime(2025, 11, 12),
      startTime: '08:00 AM',
      endTime: '06:00 PM',
      type: 'available',
    ),
    CalendarEventModel(
      id: '7',
      title: 'Available',
      date: DateTime(2025, 11, 15),
      startTime: '12:00 PM',
      endTime: '08:00 PM',
      type: 'available',
    ),
  ];

  static List<CalendarEventModel> getEventsForDate(DateTime date) {
    return events.where((event) {
      return event.date.year == date.year &&
          event.date.month == date.month &&
          event.date.day == date.day;
    }).toList();
  }

  static List<CalendarEventModel> getEventsForMonth(int year, int month) {
    return events.where((event) {
      return event.date.year == year && event.date.month == month;
    }).toList();
  }

  static List<DateTime> getAvailabilityDates() {
    return events
        .where((event) => event.isAvailable)
        .map((event) => event.date)
        .toList();
  }

  static int getAvailabilityCount() {
    return events.where((event) => event.isAvailable).length;
  }
}
