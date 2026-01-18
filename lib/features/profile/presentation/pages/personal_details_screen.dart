import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/widgets/custom_text_field.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late SignatureController _signatureController;

  // Form controllers
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _emailController = TextEditingController();
  final _nricNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _streetController = TextEditingController();
  final _blockController = TextEditingController();
  final _cityController = TextEditingController();
  final _unitController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _emergencyRelationshipController = TextEditingController();
  final _payNowController = TextEditingController();
  final _accountController = TextEditingController();
  final _bankNameController = TextEditingController();

  // State variables
  File? _profileImage;
  final ImagePicker _imagePicker = ImagePicker();
  String _selectedGender = 'Male';
  bool _isFullTimeJobs = false;
  String? _residentialStatus;
  String? _nricType;
  final Set<String> _selectedLanguages = {};
  String _criminalHistory = '';
  String _workPermit = '';
  bool _agreeTerms = false;
  bool _agreePrivacy = false;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _nameController.dispose();
    _contactController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _nricNameController.dispose();
    _dobController.dispose();
    _nationalityController.dispose();
    _zipcodeController.dispose();
    _streetController.dispose();
    _blockController.dispose();
    _cityController.dispose();
    _unitController.dispose();
    _emergencyNameController.dispose();
    _emergencyContactController.dispose();
    _emergencyRelationshipController.dispose();
    _payNowController.dispose();
    _accountController.dispose();
    _bankNameController.dispose();
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
          'Personal Details',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s18.sp,
            fontWeight: FontWeightManager.semiBold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your personal information and identification details',
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s14.sp,
                  fontWeight: FontWeightManager.regular,
                  color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: const Color(0xFF1976D2),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Verification Required: Personal details must be verified to apply for part-time job opportunities.',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s12.sp,
                          fontWeight: FontWeightManager.medium,
                          color: const Color(0xFF1976D2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Profile Picture Section
              _buildProfilePictureSection(isDark),
              SizedBox(height: 24.h),

              // Contact Information
              _buildSectionHeader('Contact Information', isDark),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: _nameController,
                label: 'Name',
                hintText: 'Enter your name',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _contactController,
                label: 'Contact',
                hintText: 'Enter contact number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _whatsappController,
                label: 'WhatsApp',
                hintText: 'Enter WhatsApp number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter email address',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),

              // Personal Information
              _buildSectionHeader('Personal Information', isDark),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: _nricNameController,
                label: 'Name as per NRIC',
                hintText: 'Enter name as per NRIC',
                prefixIcon: Icons.badge_outlined,
              ),
              SizedBox(height: 16.h),
              _buildGenderSelector(isDark),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _dobController,
                    label: 'Date of Birth',
                    hintText: 'Select date of birth',
                    prefixIcon: Icons.calendar_today,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _nationalityController,
                label: 'Nationality',
                hintText: 'Enter nationality',
                prefixIcon: Icons.flag_outlined,
              ),
              SizedBox(height: 24.h),

              // Address Section
              _buildSectionHeader('Address', isDark),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: _zipcodeController,
                label: 'Zipcode',
                hintText: 'Enter zipcode',
                prefixIcon: Icons.location_on_outlined,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _streetController,
                label: 'Street',
                hintText: 'Enter street name',
                prefixIcon: Icons.signpost_outlined,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _blockController,
                      label: 'Block',
                      hintText: 'Block',
                      prefixIcon: Icons.apartment_outlined,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomTextField(
                      controller: _unitController,
                      label: 'Unit',
                      hintText: 'Unit',
                      prefixIcon: Icons.home_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _cityController,
                label: 'City',
                hintText: 'Enter city',
                prefixIcon: Icons.location_city_outlined,
              ),
              SizedBox(height: 24.h),

              // Emergency Contact
              _buildSectionHeader('Emergency Contact', isDark),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: _emergencyNameController,
                label: 'Name',
                hintText: 'Enter emergency contact name',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _emergencyContactController,
                label: 'Contact Number',
                hintText: 'Enter emergency contact number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _emergencyRelationshipController,
                label: 'Relationship',
                hintText: 'Enter relationship',
                prefixIcon: Icons.people_outline,
              ),
              SizedBox(height: 24.h),

              // Full-time Jobs Toggle
              _buildFullTimeToggle(isDark),
              SizedBox(height: 24.h),

              // Residential Status & NRIC
              _buildSectionHeader('Status & Identification', isDark),
              SizedBox(height: 12.h),
              _buildDropdown('Residential Status', ['Citizen', 'PR', 'Work Permit', 'Student Pass'], _residentialStatus, (value) {
                setState(() => _residentialStatus = value);
              }, isDark),
              SizedBox(height: 16.h),
              _buildDropdown('NRIC', ['Singapore NRIC', 'Foreign NRIC', 'Passport'], _nricType, (value) {
                setState(() => _nricType = value);
              }, isDark),
              SizedBox(height: 24.h),

              // Bank Details
              _buildSectionHeader('Bank Details', isDark),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: _payNowController,
                label: 'PayNow Number',
                hintText: 'Enter PayNow number',
                prefixIcon: Icons.payment_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _accountController,
                label: 'Account Number',
                hintText: 'Enter account number',
                prefixIcon: Icons.account_balance_outlined,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _bankNameController,
                label: 'Bank Name',
                hintText: 'Enter bank name',
                prefixIcon: Icons.account_balance_outlined,
              ),
              SizedBox(height: 24.h),

              // Languages
              _buildSectionHeader('Languages', isDark),
              SizedBox(height: 12.h),
              _buildLanguagesCheckboxes(isDark),
              SizedBox(height: 24.h),

              // Background Information
              _buildSectionHeader('Background Information', isDark),
              SizedBox(height: 12.h),
              _buildRadioQuestion('Have you been convicted of any criminal offense?', _criminalHistory, (value) {
                setState(() => _criminalHistory = value);
              }, isDark),
              SizedBox(height: 16.h),
              _buildRadioQuestion('Do you have a valid work permit?', _workPermit, (value) {
                setState(() => _workPermit = value);
              }, isDark),
              SizedBox(height: 24.h),

              // Authorizations
              _buildSectionHeader('Authorizations', isDark),
              SizedBox(height: 12.h),
              _buildCheckbox('I agree to the terms and conditions', _agreeTerms, (value) {
                setState(() => _agreeTerms = value ?? false);
              }, isDark),
              SizedBox(height: 8.h),
              _buildCheckbox('I agree to the privacy policy', _agreePrivacy, (value) {
                setState(() => _agreePrivacy = value ?? false);
              }, isDark),
              SizedBox(height: 24.h),

              // Signature Section
              _buildSectionHeader('Signature', isDark),
              SizedBox(height: 12.h),
              _buildSignaturePad(isDark),
              SizedBox(height: 24.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.authPrimary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Submit Profile',
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

  Widget _buildProfilePictureSection(bool isDark) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _pickImage(),
            child: Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? ColorManager.darkCard : Colors.grey[200],
                    image: _profileImage != null
                        ? DecorationImage(
                            image: FileImage(_profileImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _profileImage == null
                      ? Icon(
                          Icons.person,
                          size: 50.sp,
                          color: isDark ? ColorManager.darkTextSecondary : Colors.grey[400],
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.authPrimary,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 16.sp,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            _profileImage == null ? 'Upload Profile Picture' : 'Change Picture',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.medium,
              color: ColorManager.authPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildGenderSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption('Male', isDark),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildGenderOption('Female', isDark),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String gender, bool isDark) {
    final isSelected = _selectedGender == gender;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.authPrimary.withOpacity(0.1)
              : (isDark ? ColorManager.darkCard : ColorManager.white),
          border: Border.all(
            color: isSelected
                ? ColorManager.authPrimary
                : (isDark ? ColorManager.darkBorder : ColorManager.grey4),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            gender,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: isSelected ? FontWeightManager.semiBold : FontWeightManager.regular,
              color: isSelected
                  ? ColorManager.authPrimary
                  : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullTimeToggle(bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkCard : ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Willing to do Full-time Jobs?',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    fontWeight: FontWeightManager.medium,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Enable if you can work full-time',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.regular,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isFullTimeJobs,
            onChanged: (value) {
              setState(() {
                _isFullTimeJobs = value;
              });
            },
            activeColor: ColorManager.authPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String title,
    List<String> options,
    String? selectedValue,
    Function(String?) onChanged,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: isDark ? ColorManager.darkCard : ColorManager.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              border: InputBorder.none,
            ),
            dropdownColor: isDark ? ColorManager.darkCard : ColorManager.white,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
            hint: Text(
              'Select $title',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguagesCheckboxes(bool isDark) {
    final languages = ['English', 'Mandarin', 'Malay', 'Tamil', 'Other'];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: languages.map((language) {
        final isSelected = _selectedLanguages.contains(language);
        return FilterChip(
          label: Text(language),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedLanguages.add(language);
              } else {
                _selectedLanguages.remove(language);
              }
            });
          },
          selectedColor: ColorManager.authPrimary.withOpacity(0.2),
          checkmarkColor: ColorManager.authPrimary,
          labelStyle: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            color: isSelected
                ? ColorManager.authPrimary
                : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRadioQuestion(
    String question,
    String selectedValue,
    Function(String) onChanged,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.medium,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                value: 'Yes',
                groupValue: selectedValue,
                onChanged: (value) => onChanged(value!),
                title: Text(
                  'Yes',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                ),
                activeColor: ColorManager.authPrimary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                value: 'No',
                groupValue: selectedValue,
                onChanged: (value) => onChanged(value!),
                title: Text(
                  'No',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s14.sp,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                ),
                activeColor: ColorManager.authPrimary,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckbox(
    String label,
    bool value,
    Function(bool?) onChanged,
    bool isDark,
  ) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: FontSize.s14.sp,
          color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
        ),
      ),
      activeColor: ColorManager.authPrimary,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildSignaturePad(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: isDark ? ColorManager.darkCard : ColorManager.white,
            border: Border.all(
              color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Signature(
            controller: _signatureController,
            backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
          ),
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              _signatureController.clear();
            },
            icon: Icon(Icons.clear, size: 18.sp),
            label: Text(
              'Clear',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s14.sp,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: ColorManager.authPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
        _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Personal details submitted successfully!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
