import '../models/job_detail_model.dart';

class MockJobDetail {
  static JobDetailModel getWarehouseJob() {
    return JobDetailModel(
      id: '1',
      title: 'Warehouse Associate',
      company: 'QuickShip Logistics',
      location: 'West Warehouse',
      address: 'Industrial Park West',
      distance: 8.5,
      imageUrl: 'warehouse',
      images: [
        'assets/images/warehouse1.jpg',
        'assets/images/warehouse2.jpg',
        'assets/images/warehouse3.jpg',
      ],
      category: 'Logistics',
      date: DateTime.now().add(const Duration(days: 2)),
      startTime: '06:00 AM',
      endTime: '02:00 PM',
      hourlyRate: 22,
      expectedEarnings: 176,
      spotsLeft: 8,
      isHotShift: true,
      isAISuggested: false,
      isSaved: false,
      annualSalary: 264,
      monthlySalary: 22,
      monthlyBenefits: 154,
      totalPackage: 2112,
      employmentType: 'Full-Time',
      isVerified: true,
      employeeCount: '500+',
      openRoles: 12,
      rating: 4.5,
      aboutCompany: 'QuickShip Logistics is a leading company committed to innovation and employee development. We offer competitive benefits, career growth opportunities, and a supportive work environment.',
      jobDescription: 'Looking for reliable warehouse associates to join our fast-paced distribution center. Responsibilities include picking, packing, and organizing inventory. Physical work with great pay and benefits.',
      benefits: [
        'Medical, dental & vision insurance',
        'Annual leave & public holidays',
        'Performance bonuses',
        'Professional development programs',
      ],
      requirements: [
        'Ability to lift up to 50 lbs',
        'Forklift certification (or willing to obtain)',
      ],
    );
  }
}
