class CalendarEventModel {
  final String id;
  final String title;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String type; // 'scheduled' or 'available'

  CalendarEventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
  });

  bool get isScheduled => type == 'scheduled';
  bool get isAvailable => type == 'available';

  String get timeRange => '$startTime - $endTime';
}
