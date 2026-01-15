import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../models/schedule_job_model.dart';

class ScanInScreen extends StatefulWidget {
  const ScanInScreen({
    super.key,
    required this.job,
  });

  final ScheduleJobModel job;

  @override
  State<ScanInScreen> createState() => _ScanInScreenState();
}

class _ScanInScreenState extends State<ScanInScreen> {
  final MobileScannerController _controller = MobileScannerController(
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDetection(BarcodeCapture capture) {
    final code = capture.barcodes.first.rawValue;
    if (code != null && code.isNotEmpty) {
      Navigator.pop(context, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan In'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch_rounded),
            onPressed: () => _controller.switchCamera(),
          ),
          IconButton(
            icon: const Icon(Icons.flash_on_rounded),
            onPressed: () => _controller.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _handleDetection,
            errorBuilder: (context, error) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Container(
                color: isDark ? ColorManager.darkBackground : ColorManager.backgroundColor,
                alignment: Alignment.center,
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64.sp,
                      color: ColorManager.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Unable to access camera',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s18.sp,
                        fontWeight: FontWeightManager.semiBold,
                        color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Please ensure camera permissions are granted and restart the app after installing scanner support.',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s14.sp,
                        fontWeight: FontWeightManager.regular,
                        color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.authPrimary,
                        foregroundColor: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: GoogleFonts.poppins(
                          fontSize: FontSize.s14.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 28.h,
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: (isDark ? ColorManager.darkCard : ColorManager.white).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: ColorManager.authPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.work_outline_rounded,
                      color: ColorManager.authPrimary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.job.title,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Align the QR code within the frame to scan in.',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s12.sp,
                            fontWeight: FontWeightManager.regular,
                            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 260.w,
              height: 260.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.authPrimary,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
