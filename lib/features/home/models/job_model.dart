class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String address;
  final double distance; // in km
  final DateTime date;
  final String startTime;
  final String endTime;
  final double hourlyRate;
  final double expectedEarnings;
  final int spotsLeft;
  final String imageUrl;
  final bool isHotShift;
  final bool isAISuggested;
  final bool isSaved;
  final String category;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.address,
    required this.distance,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.hourlyRate,
    required this.expectedEarnings,
    required this.spotsLeft,
    required this.imageUrl,
    this.isHotShift = false,
    this.isAISuggested = false,
    this.isSaved = false,
    required this.category,
  });

  String get dateFormatted {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  String get timeRange => '$startTime - $endTime';
}
