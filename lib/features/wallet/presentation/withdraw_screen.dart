import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';

class WithdrawScreen extends StatefulWidget {
  final double availableBalance;

  const WithdrawScreen({
    super.key,
    required this.availableBalance,
  });

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _selectedAmount = 0.0;
  final double _minimumWithdrawal = 10.00;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _selectAmount(double amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toStringAsFixed(2);
    });
  }

  void _confirmWithdrawal() {
    if (_selectedAmount < _minimumWithdrawal) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Minimum withdrawal amount is \$$_minimumWithdrawal',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_selectedAmount > widget.availableBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Insufficient balance',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    // TODO: Implement actual withdrawal logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: const Color(0xFF10B981),
              size: 28.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Success',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s18.sp,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Your withdrawal request of \$${_selectedAmount.toStringAsFixed(2)} has been submitted successfully.',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'OK',
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.authBackground,
      appBar: AppBar(
        backgroundColor: isDark ? ColorManager.darkCard : ColorManager.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Withdraw Funds',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s18.sp,
                fontWeight: FontWeightManager.bold,
                color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
              ),
            ),
            Text(
              'Transfer money to your bank account',
              style: GoogleFonts.poppins(
                fontSize: FontSize.s12.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Balance Card
            _buildBalanceCard(isDark),
            SizedBox(height: 24.h),

            // Enter Amount Section
            _buildEnterAmountSection(isDark),
            SizedBox(height: 32.h),

            // Withdrawal Information
            _buildWithdrawalInfo(isDark),
            SizedBox(height: 32.h),

            // Confirm Button
            _buildConfirmButton(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.authPrimary.withValues(alpha: 0.1),
            ColorManager.authPrimary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.authPrimary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s12.sp,
                    fontWeight: FontWeightManager.medium,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$${widget.availableBalance.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s32.sp,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.authPrimary,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.authPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              size: 32.sp,
              color: ColorManager.authPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnterAmountSection(bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkCard : ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Amount',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Minimum withdrawal amount is \$$_minimumWithdrawal',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s12.sp,
              fontWeight: FontWeightManager.regular,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),

          // Amount Input
          Text(
            'Withdrawal Amount',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s13.sp,
              fontWeight: FontWeightManager.semiBold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedAmount = double.tryParse(value) ?? 0.0;
              });
            },
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.semiBold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 8.w),
                child: Text(
                  '\$',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              hintText: '0.00',
              hintStyle: GoogleFonts.poppins(
                fontSize: FontSize.s16.sp,
                fontWeight: FontWeightManager.regular,
                color: isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary,
              ),
              filled: true,
              fillColor: isDark
                  ? ColorManager.darkBackground
                  : ColorManager.authSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: ColorManager.authPrimary,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
          SizedBox(height: 20.h),

          // Quick Select
          Text(
            'Quick Select',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s13.sp,
              fontWeight: FontWeightManager.semiBold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              _buildQuickSelectButton(isDark, 50),
              _buildQuickSelectButton(isDark, 100),
              _buildQuickSelectButton(isDark, 250),
              _buildQuickSelectButton(isDark, 500),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: _buildQuickSelectButton(
              isDark,
              widget.availableBalance,
              label: 'All (\$${widget.availableBalance.toStringAsFixed(2)})',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSelectButton(bool isDark, double amount, {String? label}) {
    final isSelected = _selectedAmount == amount;

    return InkWell(
      onTap: () => _selectAmount(amount),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.authPrimary
              : (isDark ? ColorManager.darkBackground : ColorManager.authSurface),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.authPrimary
                : (isDark ? ColorManager.darkBorder : ColorManager.grey4),
            width: 1,
          ),
        ),
        child: Text(
          label ?? '\$${amount.toInt()}',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s14.sp,
            fontWeight: FontWeightManager.semiBold,
            color: isSelected
                ? ColorManager.white
                : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
          ),
        ),
      ),
    );
  }

  Widget _buildWithdrawalInfo(bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark
            ? ColorManager.darkCard
            : const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Withdrawal Information',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(isDark, 'Processing time: 1-3 business days'),
          SizedBox(height: 8.h),
          _buildInfoRow(isDark, 'Funds will be transferred to your linked bank account'),
          SizedBox(height: 8.h),
          _buildInfoRow(isDark, 'No withdrawal fees applied'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(bool isDark, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 16.sp,
          color: ColorManager.authPrimary,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s12.sp,
              fontWeight: FontWeightManager.regular,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(bool isDark) {
    final bool isValid = _selectedAmount >= _minimumWithdrawal &&
        _selectedAmount <= widget.availableBalance;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: isValid ? _confirmWithdrawal : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.authPrimary,
          disabledBackgroundColor: isDark
              ? ColorManager.darkBorder
              : ColorManager.grey4,
          foregroundColor: ColorManager.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Confirm Withdrawal',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s16.sp,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
      ),
    );
  }
}
