import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';

class ProfessionalProfileScreen extends StatefulWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  State<ProfessionalProfileScreen> createState() => _ProfessionalProfileScreenState();
}

class _ProfessionalProfileScreenState extends State<ProfessionalProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _bioController = TextEditingController();
  final _expectedSalaryController = TextEditingController();
  final _startDateController = TextEditingController();
  final _rolesController = TextEditingController();

  // State variables
  final Set<String> _selectedSkills = {'Communication', 'Teamwork'};
  final List<Map<String, String>> _certifications = [];
  final List<Map<String, String>> _experiences = [];
  final List<Map<String, String>> _education = [];
  final List<String> _selectedDays = ['Mon', 'Tue', 'Wed'];
  String _selectedShift = 'Morning';
  String _linkedInUrl = '';
  String _portfolioUrl = '';
  String _githubUrl = '';
  String? _portfolioFileName;
  String? _portfolioFilePath;

  @override
  void dispose() {
    _bioController.dispose();
    _expectedSalaryController.dispose();
    _startDateController.dispose();
    _rolesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Professional Profile',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.semiBold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorManager.grey3,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Optional',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enhance your profile with professional details',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.regular,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),

              // Bio Section
              _buildSectionHeader('Bio', isDark),
              SizedBox(height: 12.h),
              _buildBioSection(isDark),
              SizedBox(height: 24.h),

              // Job Preferences
              _buildSectionHeader('Job Preferences', isDark),
              SizedBox(height: 12.h),
              _buildJobPreferencesSection(isDark),
              SizedBox(height: 24.h),

              // Availability & Schedule
              _buildSectionHeader('Availability & Schedule', isDark),
              SizedBox(height: 12.h),
              _buildAvailabilitySection(isDark),
              SizedBox(height: 24.h),

              // Skills
              _buildSectionHeader('Skills', isDark),
              SizedBox(height: 12.h),
              _buildSkillsSection(isDark),
              SizedBox(height: 24.h),

              // Certifications
              _buildSectionHeader('Certifications', isDark),
              SizedBox(height: 12.h),
              _buildCertificationsSection(isDark),
              SizedBox(height: 24.h),

              // Work Experience
              _buildSectionHeader('Work Experience', isDark),
              SizedBox(height: 12.h),
              _buildExperienceSection(isDark),
              SizedBox(height: 24.h),

              // Education
              _buildSectionHeader('Education', isDark),
              SizedBox(height: 12.h),
              _buildEducationSection(isDark),
              SizedBox(height: 24.h),

              // Portfolio & Links
              _buildSectionHeader('Portfolio & Links', isDark),
              SizedBox(height: 12.h),
              _buildPortfolioSection(isDark),
              SizedBox(height: 24.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.authPrimary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save Profile',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s16.sp,
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

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeightManager.semiBold,
        color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildBioSection(bool isDark) {
    return TextFormField(
      controller: _bioController,
      maxLines: 4,
      style: GoogleFonts.poppins(
        fontSize: FontSize.s14.sp,
        color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Tell us about yourself and your professional background...',
        hintStyle: GoogleFonts.poppins(
          fontSize: FontSize.s14.sp,
          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
        ),
        filled: true,
        fillColor: isDark ? ColorManager.darkCard : ColorManager.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorManager.authPrimary),
        ),
      ),
    );
  }

  Widget _buildJobPreferencesSection(bool isDark) {
    return Column(
      children: [
        _buildTextField('Expected Salary (SGD)', _expectedSalaryController, isDark, keyboardType: TextInputType.number),
        SizedBox(height: 16.h),
        _buildTextField('Earliest Start Date', _startDateController, isDark,
          suffixIcon: Icons.calendar_today,
          readOnly: true,
          onTap: () => _selectDate(context)),
        SizedBox(height: 16.h),
        _buildTextField('Preferred Roles', _rolesController, isDark),
      ],
    );
  }

  Widget _buildAvailabilitySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Shift',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          children: ['Morning', 'Afternoon', 'Evening', 'Night'].map((shift) {
            final isSelected = _selectedShift == shift;
            return ChoiceChip(
              label: Text(shift),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedShift = shift;
                });
              },
              selectedColor: ColorManager.authPrimary.withValues(alpha: 0.2),
              labelStyle: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                color: isSelected ? ColorManager.authPrimary : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),
        Text(
          'Available Days',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
            final isSelected = _selectedDays.contains(day);
            return FilterChip(
              label: Text(day),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedDays.add(day);
                  } else {
                    _selectedDays.remove(day);
                  }
                });
              },
              selectedColor: ColorManager.authPrimary.withValues(alpha: 0.2),
              checkmarkColor: ColorManager.authPrimary,
              labelStyle: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                color: isSelected ? ColorManager.authPrimary : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _selectedSkills.map((skill) {
            return Chip(
              label: Text(skill),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () {
                setState(() {
                  _selectedSkills.remove(skill);
                });
              },
              backgroundColor: ColorManager.authPrimary.withValues(alpha: 0.1),
              labelStyle: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                color: ColorManager.authPrimary,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        OutlinedButton.icon(
          onPressed: () => _showAddSkillDialog(isDark),
          icon: const Icon(Icons.add),
          label: Text(
            'Add Skill',
            style: GoogleFonts.poppins(fontSize: FontSize.s14.sp),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: ColorManager.authPrimary,
            side: const BorderSide(color: ColorManager.authPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAddSkillDialog(bool isDark) async {
    final TextEditingController skillController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? ColorManager.darkCard : ColorManager.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: ColorManager.authPrimary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: ColorManager.authPrimary,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Add Skill',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s20.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Enter a skill to add to your profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              TextField(
                controller: skillController,
                autofocus: true,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g., Project Management',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                  filled: true,
                  fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: BorderSide(color: isDark ? ColorManager.darkBorder : ColorManager.grey4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.medium,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (skillController.text.trim().isNotEmpty) {
                          setState(() {
                            _selectedSkills.add(skillController.text.trim());
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.authPrimary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Add',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddCertificationDialog(bool isDark) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController issuerController = TextEditingController();
    String? fileName;
    String? imagePath;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(maxHeight: 600.h),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ColorManager.authPrimary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.verified_outlined,
                      color: ColorManager.authPrimary,
                      size: 32.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Add Certification',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s20.sp,
                      fontWeight: FontWeightManager.bold,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Add your professional certifications',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  TextField(
                    controller: nameController,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Certification Name',
                      labelStyle: GoogleFonts.poppins(
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                      hintText: 'e.g., AWS Certified Developer',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: FontSize.s14.sp,
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                      filled: true,
                      fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: issuerController,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Issuing Organization',
                      labelStyle: GoogleFonts.poppins(
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                      hintText: 'e.g., Amazon Web Services',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: FontSize.s14.sp,
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                      ),
                      filled: true,
                      fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1000,
                        maxHeight: 1000,
                        imageQuality: 85,
                      );

                      if (pickedFile != null) {
                        setState(() {
                          fileName = pickedFile.name;
                          imagePath = pickedFile.path;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ColorManager.authPrimary.withValues(alpha: 0.3),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            imagePath != null ? Icons.check_circle : Icons.cloud_upload_outlined,
                            color: ColorManager.authPrimary,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              fileName ?? 'Upload Certificate Image',
                              style: GoogleFonts.poppins(
                                fontSize: FontSize.s14.sp,
                                fontWeight: FontWeightManager.medium,
                                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (imagePath != null)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          File(imagePath!),
                          height: 150.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(color: isDark ? ColorManager.darkBorder : ColorManager.grey4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s14.sp,
                              fontWeight: FontWeightManager.medium,
                              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.trim().isNotEmpty && issuerController.text.trim().isNotEmpty) {
                              this.setState(() {
                                _certifications.add({
                                  'name': nameController.text.trim(),
                                  'issuer': issuerController.text.trim(),
                                  'file': fileName ?? '',
                                  'imagePath': imagePath ?? '',
                                });
                              });
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.authPrimary,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              fontSize: FontSize.s14.sp,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCertificationsSection(bool isDark) {
    return Column(
      children: [
        if (_certifications.isEmpty)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            child: Center(
              child: Text(
                'No certifications added yet',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        else
          ...(_certifications.map((cert) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.verified, color: ColorManager.authPrimary, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cert['name'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                        ),
                      ),
                      Text(
                        cert['issuer'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
        SizedBox(height: 12.h),
        OutlinedButton.icon(
          onPressed: () => _showAddCertificationDialog(isDark),
          icon: const Icon(Icons.add),
          label: Text(
            'Add Certification',
            style: GoogleFonts.poppins(fontSize: FontSize.s14.sp),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: ColorManager.authPrimary,
            side: const BorderSide(color: ColorManager.authPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAddExperienceDialog(bool isDark) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController companyController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? ColorManager.darkCard : ColorManager.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ColorManager.authPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.work_outline,
                    color: ColorManager.authPrimary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Add Work Experience',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s20.sp,
                    fontWeight: FontWeightManager.bold,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Share your work experience details',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                TextField(
                  controller: titleController,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    hintText: 'e.g., Software Engineer',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: companyController,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    hintText: 'e.g., Google Inc.',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: durationController,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Duration',
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    hintText: 'e.g., 2020 - 2023',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: BorderSide(color: isDark ? ColorManager.darkBorder : ColorManager.grey4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.medium,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.trim().isNotEmpty &&
                              companyController.text.trim().isNotEmpty &&
                              durationController.text.trim().isNotEmpty) {
                            setState(() {
                              _experiences.add({
                                'title': titleController.text.trim(),
                                'company': companyController.text.trim(),
                                'duration': durationController.text.trim(),
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.authPrimary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_experiences.isEmpty)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            child: Center(
              child: Text(
                'No work experience added yet',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        else
          ...(_experiences.map((exp) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.work_outline, color: ColorManager.authPrimary, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp['title'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                        ),
                      ),
                      Text(
                        exp['company'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                      Text(
                        exp['duration'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
        SizedBox(height: 12.h),
        OutlinedButton.icon(
          onPressed: () => _showAddExperienceDialog(isDark),
          icon: const Icon(Icons.add),
          label: Text(
            'Add Experience',
            style: GoogleFonts.poppins(fontSize: FontSize.s14.sp),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: ColorManager.authPrimary,
            side: const BorderSide(color: ColorManager.authPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAddEducationDialog(bool isDark) async {
    final TextEditingController degreeController = TextEditingController();
    final TextEditingController schoolController = TextEditingController();
    final TextEditingController yearController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? ColorManager.darkCard : ColorManager.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ColorManager.authPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    color: ColorManager.authPrimary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Add Education',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s20.sp,
                    fontWeight: FontWeightManager.bold,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Add your educational background',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                TextField(
                  controller: degreeController,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Degree',
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    hintText: 'e.g., Bachelor of Science',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: schoolController,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'School/University',
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    hintText: 'e.g., MIT',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: yearController,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    hintText: 'e.g., 2020',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: FontSize.s14.sp,
                      color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: ColorManager.authPrimary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: BorderSide(color: isDark ? ColorManager.darkBorder : ColorManager.grey4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.medium,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (degreeController.text.trim().isNotEmpty &&
                              schoolController.text.trim().isNotEmpty &&
                              yearController.text.trim().isNotEmpty) {
                            setState(() {
                              _education.add({
                                'degree': degreeController.text.trim(),
                                'school': schoolController.text.trim(),
                                'year': yearController.text.trim(),
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.authPrimary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_education.isEmpty)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            child: Center(
              child: Text(
                'No education added yet',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        else
          ...(_education.map((edu) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.school_outlined, color: ColorManager.authPrimary, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edu['degree'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                        ),
                      ),
                      Text(
                        edu['school'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                      Text(
                        edu['year'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
        SizedBox(height: 12.h),
        OutlinedButton.icon(
          onPressed: () => _showAddEducationDialog(isDark),
          icon: const Icon(Icons.add),
          label: Text(
            'Add Education',
            style: GoogleFonts.poppins(fontSize: FontSize.s14.sp),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: ColorManager.authPrimary,
            side: const BorderSide(color: ColorManager.authPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickPortfolioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
    );

    if (result != null) {
      setState(() {
        _portfolioFileName = result.files.single.name;
        _portfolioFilePath = result.files.single.path;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: ColorManager.white),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Portfolio uploaded successfully!',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            margin: EdgeInsets.all(16.w),
          ),
        );
      }
    }
  }

  Widget _buildPortfolioSection(bool isDark) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickPortfolioFile,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.darkCard : ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: _portfolioFileName != null
                    ? ColorManager.authPrimary.withValues(alpha: 0.5)
                    : (isDark ? ColorManager.darkBorder : ColorManager.grey4),
                width: _portfolioFileName != null ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorManager.authPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    _portfolioFileName != null ? Icons.check_circle : Icons.upload_file,
                    color: ColorManager.authPrimary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _portfolioFileName ?? 'Upload Portfolio',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _portfolioFileName != null
                            ? 'Tap to change file'
                            : 'PDF, DOC, DOCX, PPT (Max 10MB)',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        _buildTextField('LinkedIn URL', TextEditingController(text: _linkedInUrl), isDark),
        SizedBox(height: 16.h),
        _buildTextField('Portfolio URL', TextEditingController(text: _portfolioUrl), isDark),
        SizedBox(height: 16.h),
        _buildTextField('GitHub URL', TextEditingController(text: _githubUrl), isDark),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDark, {
    TextInputType? keyboardType,
    IconData? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? ColorManager.darkCard : ColorManager.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: ColorManager.authPrimary),
            ),
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    size: 20.sp,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorManager.authPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Professional profile saved successfully!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
