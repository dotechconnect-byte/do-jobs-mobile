import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/consts/color_manager.dart';
import '../../../core/consts/font_manager.dart';
import '../data/mock_transactions.dart';
import '../models/transaction_model.dart';
import 'withdraw_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedType = 'All Types';
  String _selectedStatus = 'All Status';
  String _selectedRange = 'Past 7 Days';
  final List<String> _rangeOptions = ['Past 7 Days', 'Past 30 Days', 'Past 90 Days'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? ColorManager.darkBackground : ColorManager.authBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Balance section
              _buildBalanceSection(isDark),

              // Stats cards
              _buildStatsCards(isDark),

              SizedBox(height: 16.h),

              // Tab bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: isDark ? ColorManager.darkCard : ColorManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _buildTabBar(isDark),
                ),
              ),

              SizedBox(height: 16.h),

              // Tab content - non-scrollable within SingleChildScrollView
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildPaymentHistoryContent(isDark),
                    _buildEarningsOverviewContent(isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceSection(bool isDark) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  ColorManager.authPrimary,
                  ColorManager.authPrimaryDark,
                ]
              : [
                  const Color(0xFFF5F3FF),
                  const Color(0xFFEDE9FE),
                ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.authPrimary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? ColorManager.white.withValues(alpha: 0.2)
                      : ColorManager.authPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 24.sp,
                  color: isDark ? ColorManager.white : ColorManager.authPrimary,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WithdrawScreen(
                        availableBalance: 1247.50,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_upward,
                  size: 18.sp,
                  color: ColorManager.white,
                ),
                label: Text(
                  'Withdraw',
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s13.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.authPrimary,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'AVAILABLE BALANCE',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s11.sp,
              fontWeight: FontWeightManager.medium,
              color: isDark
                  ? ColorManager.white.withValues(alpha: 0.7)
                  : ColorManager.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$1247.50',
                style: GoogleFonts.poppins(
                  fontSize: 40.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isDark ? ColorManager.white : ColorManager.textPrimary,
                  height: 1.2,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 12.sp,
                      color: const Color(0xFF10B981),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '+12%',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s11.sp,
                        fontWeight: FontWeightManager.bold,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(bool isDark) {
    return SizedBox(
      height: 140.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          // Pending Payments
          SizedBox(
            width: 150.w,
            child: _buildStatCard(
              isDark: isDark,
              icon: Icons.schedule_outlined,
              label: 'PENDING',
              amount: '\$325',
              subtitle: 'Processing',
              badgeText: 'Pending',
              badgeColor: const Color(0xFFF59E0B),
              iconColor: const Color(0xFFF59E0B),
            ),
          ),
          SizedBox(width: 12.w),
          // This Week
          SizedBox(
            width: 150.w,
            child: _buildStatCard(
              isDark: isDark,
              icon: Icons.trending_up_outlined,
              label: 'THIS WEEK',
              amount: '\$1079',
              subtitle: '7 days',
              percentageChange: '+18%',
              iconColor: const Color(0xFF10B981),
            ),
          ),
          SizedBox(width: 12.w),
          // Health Score
          SizedBox(
            width: 150.w,
            child: _buildHealthScoreCard(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required bool isDark,
    required IconData icon,
    required String label,
    required String amount,
    required String subtitle,
    String? badgeText,
    Color? badgeColor,
    String? percentageChange,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: iconColor,
                ),
              ),
              const Spacer(),
              if (badgeText != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: badgeColor?.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s10.sp,
                      fontWeight: FontWeightManager.semiBold,
                      color: badgeColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s10.sp,
              fontWeight: FontWeightManager.medium,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              letterSpacing: 0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Flexible(
                child: Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s10.sp,
                    fontWeight: FontWeightManager.regular,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (percentageChange != null) ...[
                SizedBox(width: 4.w),
                Text(
                  percentageChange,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s10.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScoreCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(14.w),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.favorite_outline,
                  size: 18.sp,
                  color: const Color(0xFF3B82F6),
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 36.w,
                    height: 36.w,
                    child: CircularProgressIndicator(
                      value: 0.87,
                      strokeWidth: 3.w,
                      backgroundColor: isDark
                          ? ColorManager.darkBorder
                          : ColorManager.grey4,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                  Text(
                    '87',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s11.sp,
                      fontWeight: FontWeightManager.bold,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'HEALTH SCORE',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s10.sp,
              fontWeight: FontWeightManager.medium,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
              letterSpacing: 0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            '87 /100',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.bold,
              color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            '127 shifts',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s10.sp,
              fontWeight: FontWeightManager.regular,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar(bool isDark) {
    return TabBar(
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: isDark ? ColorManager.authPrimary.withValues(alpha: 0.2) : const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(10.r),
      ),
      labelColor: ColorManager.authPrimary,
      unselectedLabelColor: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
      labelStyle: GoogleFonts.poppins(
        fontSize: FontSize.s13.sp,
        fontWeight: FontWeightManager.semiBold,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: FontSize.s13.sp,
        fontWeight: FontWeightManager.medium,
      ),
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(text: 'Payment History'),
        Tab(text: 'Earnings Overview'),
      ],
    );
  }

  Widget _buildPaymentHistoryContent(bool isDark) {
    final transactions = MockTransactions.transactions;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Section Title
        Text(
          'Recent Transactions',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s16.sp,
            fontWeight: FontWeightManager.bold,
            color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Your payment activity',
          style: GoogleFonts.poppins(
            fontSize: FontSize.s12.sp,
            fontWeight: FontWeightManager.regular,
            color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 16.h),

        // Filters
        Row(
          children: [
            Expanded(
              child: _buildFilterDropdown(
                isDark,
                _selectedType,
                ['All Types', 'Incoming', 'Withdrawals'],
                (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildFilterDropdown(
                isDark,
                _selectedStatus,
                ['All Status', 'Completed', 'Pending', 'Processing'],
                (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Transaction list
        ...transactions.map((transaction) => _buildTransactionItem(isDark, transaction)),

        SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    bool isDark,
    String value,
    List<String> options,
    Function(String) onChanged,
  ) {
    return GestureDetector(
      onTap: () {
        _showFilterOptions(isDark, value, options, onChanged);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isDark ? ColorManager.darkCard : ColorManager.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s12.sp,
                  fontWeight: FontWeightManager.medium,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20.sp,
              color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(
    bool isDark,
    String currentValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? ColorManager.darkCard : ColorManager.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isDark ? ColorManager.darkBorder : ColorManager.grey4,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            // Options
            ...options.map((option) {
              final isSelected = option == currentValue;
              return InkWell(
                onTap: () {
                  onChanged(option);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.authPrimary.withValues(alpha: 0.1)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14.sp,
                            fontWeight: isSelected
                                ? FontWeightManager.semiBold
                                : FontWeightManager.medium,
                            color: isSelected
                                ? ColorManager.authPrimary
                                : (isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          size: 20.sp,
                          color: ColorManager.authPrimary,
                        ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(bool isDark, TransactionModel transaction) {
    final isIncoming = transaction.type == 'incoming';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkCard : ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isIncoming
                  ? const Color(0xFF10B981).withValues(alpha: 0.1)
                  : const Color(0xFFEF4444).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
              size: 20.sp,
              color: isIncoming ? const Color(0xFF10B981) : const Color(0xFFEF4444),
            ),
          ),
          SizedBox(width: 12.w),

          // Title and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s13.sp,
                    fontWeight: FontWeightManager.semiBold,
                    color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  transaction.date,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s11.sp,
                    fontWeight: FontWeightManager.regular,
                    color: isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary,
                  ),
                ),
                if (transaction.jobId != null) ...[
                  SizedBox(height: 4.h),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to job details
                    },
                    child: Text(
                      'View job details →',
                      style: GoogleFonts.poppins(
                        fontSize: FontSize.s10.sp,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.authPrimary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Amount and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.formattedAmount,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s15.sp,
                  fontWeight: FontWeightManager.bold,
                  color: isIncoming ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  transaction.status,
                  style: GoogleFonts.poppins(
                    fontSize: FontSize.s10.sp,
                    fontWeight: FontWeightManager.medium,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsOverviewContent(bool isDark) {
    final earnings = _getEarningsData(_selectedRange);

    final double maxAmount = earnings.map((e) => e['amount'] as double).reduce((a, b) => a > b ? a : b);
    final double total = earnings.fold(0, (sum, e) => sum + (e['amount'] as double));
    final double average = total / earnings.length;
    final double highest = earnings.map((e) => e['amount'] as double).reduce((a, b) => a > b ? a : b);
    final textPrimary = isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary;
    final textSecondary = isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? ColorManager.darkCard : ColorManager.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withValues(alpha: 0.3) : ColorManager.authPrimary.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: isDark ? ColorManager.darkBorder : ColorManager.grey4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12.w,
                runSpacing: 8.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 140.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Track Your Earnings',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s16.sp,
                            fontWeight: FontWeightManager.semiBold,
                            color: textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Monitor your income performance',
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s12.sp,
                            fontWeight: FontWeightManager.regular,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildRangeSelector(isDark, textSecondary),
                ],
              ),
              SizedBox(height: 16.h),
              _buildSummaryRow(
                isDark: isDark,
                total: total,
                average: average,
                highest: highest,
                shifts: earnings.length,
                textPrimary: textPrimary,
                textSecondary: textSecondary,
              ),
              SizedBox(height: 20.h),
              _buildBarChart(
                isDark: isDark,
                earnings: earnings,
                maxAmount: maxAmount,
                textPrimary: textPrimary,
                textSecondary: textSecondary,
              ),
            ],
          ),
      ),
    );
  }

  List<Map<String, Object>> _getEarningsData(String range) {
    switch (range) {
      case 'Past 30 Days':
        return [
          {'label': 'Week 1', 'amount': 520.0},
          {'label': 'Week 2', 'amount': 680.0},
          {'label': 'Week 3', 'amount': 610.0},
          {'label': 'Week 4', 'amount': 740.0},
        ];
      case 'Past 90 Days':
        return [
          {'label': 'Aug', 'amount': 1820.0},
          {'label': 'Sep', 'amount': 2010.0},
          {'label': 'Oct', 'amount': 2145.0},
        ];
      case 'Past 7 Days':
      default:
        return [
          {'label': 'Oct 22', 'amount': 110.0},
          {'label': 'Oct 23', 'amount': 170.0},
          {'label': 'Oct 24', 'amount': 95.0},
          {'label': 'Oct 25', 'amount': 180.0},
          {'label': 'Oct 26', 'amount': 145.0},
          {'label': 'Oct 27', 'amount': 205.0},
          {'label': 'Oct 28', 'amount': 155.0},
        ];
    }
  }

  Widget _buildRangeSelector(bool isDark, Color textSecondary) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () => _showFilterOptions(
          isDark,
          _selectedRange,
          _rangeOptions,
          (value) {
            setState(() {
              _selectedRange = value;
            });
          },
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    colors: [
                      ColorManager.darkInput,
                      ColorManager.darkCard.withValues(alpha: 0.9),
                    ],
                  )
                : LinearGradient(
                    colors: [
                      ColorManager.authSurface,
                      ColorManager.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: isDark ? ColorManager.darkBorder : ColorManager.authInputBorder),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: ColorManager.authPrimary.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: ColorManager.authPrimary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.query_stats_rounded,
                  color: ColorManager.authPrimary,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                _selectedRange,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s12.sp,
                  fontWeight: FontWeightManager.semiBold,
                  color: isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: textSecondary,
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required bool isDark,
    required double total,
    required double average,
    required double highest,
    required int shifts,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final cards = [
      _SummaryCardData(
        title: 'Total',
        value: total,
        color: ColorManager.authPrimary.withValues(alpha: 0.08),
        textColor: ColorManager.authPrimary,
      ),
      _SummaryCardData(
        title: 'Average',
        value: average,
        color: ColorManager.authPrimaryLight.withValues(alpha: 0.08),
        textColor: ColorManager.authPrimary,
      ),
      _SummaryCardData(
        title: 'Highest',
        value: highest,
        color: const Color(0xFFDCFCE7),
        textColor: const Color(0xFF16A34A),
      ),
      _SummaryCardData(
        title: 'Shifts',
        value: shifts.toDouble(),
        color: const Color(0xFFFFF7E6),
        textColor: const Color(0xFFF59E0B),
        isInteger: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: cards
              .map(
                (card) => SizedBox(
                  width: constraints.maxWidth > 700 ? (constraints.maxWidth - 36.w) / 4 : (constraints.maxWidth - 12.w) / 2,
                  child: _buildSummaryCard(
                    isDark: isDark,
                    data: card,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildSummaryCard({
    required bool isDark,
    required _SummaryCardData data,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.darkInput : data.color,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: isDark ? ColorManager.darkBorder : ColorManager.authInputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: GoogleFonts.poppins(
              fontSize: FontSize.s12.sp,
              fontWeight: FontWeightManager.medium,
              color: textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            data.isInteger ? data.value.toInt().toString() : '\$${data.value.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: FontSize.s18.sp,
              fontWeight: FontWeightManager.bold,
              color: data.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart({
    required bool isDark,
    required List<Map<String, Object>> earnings,
    required double maxAmount,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final gradient = isDark
        ? const LinearGradient(
            colors: [Color(0xFF9F7AEA), Color(0xFF6D28D9)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )
        : const LinearGradient(
            colors: [Color(0xFFB794F4), Color(0xFF7C3AED)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          );

    return SizedBox(
      height: 260.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = (constraints.maxWidth - (earnings.length - 1) * 16.w) / earnings.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildBarWidgets(
                    earnings: earnings,
                    barWidth: barWidth,
                    constraints: constraints,
                    gradient: gradient,
                    isDark: isDark,
                    textSecondary: textSecondary,
                    maxAmount: maxAmount,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$0',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s11.sp,
                      color: textSecondary,
                    ),
                  ),
                  Text(
                    '\$${maxAmount.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: FontSize.s11.sp,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildBarWidgets({
    required List<Map<String, Object>> earnings,
    required double barWidth,
    required BoxConstraints constraints,
    required Gradient gradient,
    required bool isDark,
    required Color textSecondary,
    required double maxAmount,
  }) {
    final List<Widget> bars = [];
    for (int i = 0; i < earnings.length; i++) {
      final data = earnings[i];
      final amount = data['amount'] as double;
      final heightFactor = (amount / maxAmount).clamp(0.0, 1.0);

      bars.add(
        SizedBox(
          width: barWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: (constraints.maxHeight - 40.h) * heightFactor,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.25)
                              : ColorManager.authPrimary.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                data['label'] as String,
                style: GoogleFonts.poppins(
                  fontSize: FontSize.s11.sp,
                  fontWeight: FontWeightManager.medium,
                  color: textSecondary,
                ),
              ),
            ],
          ),
        ),
      );

      if (i != earnings.length - 1) {
        bars.add(SizedBox(width: 16.w));
      }
    }
    return bars;
  }
}

class _SummaryCardData {
  final String title;
  final double value;
  final Color color;
  final Color textColor;
  final bool isInteger;

  _SummaryCardData({
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
    this.isInteger = false,
  });
}
