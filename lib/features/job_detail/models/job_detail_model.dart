class JobDetailModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String address;
  final double distance;
  final String imageUrl;
  final List<String> images;
  final String category;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double hourlyRate;
  final double expectedEarnings;
  final int spotsLeft;
  final bool isHotShift;
  final bool isAISuggested;
  final bool isSaved;

  // Additional details
  final double annualSalary;
  final double monthlySalary;
  final double monthlyBenefits;
  final double totalPackage;
  final String employmentType;
  final bool isVerified;
  final String employeeCount;
  final int openRoles;
  final double rating;
  final String aboutCompany;
  final String jobDescription;
  final List<String> benefits;
  final List<String> requirements;

  JobDetailModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.address,
    required this.distance,
    required this.imageUrl,
    required this.images,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.hourlyRate,
    required this.expectedEarnings,
    required this.spotsLeft,
    required this.isHotShift,
    required this.isAISuggested,
    required this.isSaved,
    required this.annualSalary,
    required this.monthlySalary,
    required this.monthlyBenefits,
    required this.totalPackage,
    required this.employmentType,
    required this.isVerified,
    required this.employeeCount,
    required this.openRoles,
    required this.rating,
    required this.aboutCompany,
    required this.jobDescription,
    required this.benefits,
    required this.requirements,
  });

  String get dateFormatted {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  String get timeRange => '$startTime - $endTime';
}
