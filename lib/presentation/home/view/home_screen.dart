import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/user_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(incomesProvider.notifier).fetchIncomes();
      ref.read(userProvider.notifier).loadUser();
    });
  }

  double _monthlyMultiplier(String frequency) {
    switch (frequency) {
      case 'WEEKLY':
        return 4.33;
      case 'EVERY_2_WEEKS':
        return 2.17;
      case 'TWICE_A_MONTH':
        return 2;
      case 'MONTHLY':
        return 1;
      default:
        return 1;
    }
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  double _monthlyMultiplierFromIndex(int index) {
    switch (index) {
      case 0:
        return 4.33;
      case 1:
        return 2.17;
      case 2:
        return 2;
      case 3:
        return 1;
      default:
        return 1;
    }
  }

  String _payFrequencyLabel(int index) {
    const labels = ['weekly', 'every 2 weeks', 'twice a month', 'monthly'];
    return index < labels.length
        ? '${labels[index]} paycheck'
        : 'monthly paycheck';
  }

  @override
  Widget build(BuildContext context) {
    final incomeState = ref.watch(incomesProvider);
    final userState = ref.watch(userProvider);
    final setupData = ref.watch(setupDataProvider);
    final now = DateTime.now();

    final userName = userState.user?.name ?? 'there';
    final greeting = _greeting();

    double safeToSpend;
    double breakdownMonthlyIncome;
    double breakdownBills;
    String payFrequencyLabel;
    int billsCount;
    debugPrint("incomeState: ${incomeState.safeToSpend}");

    if (incomeState.incomes.isNotEmpty) {
      final monthlyIncome = incomeState.incomes.fold<double>(
        0,
        (sum, i) => sum + i.baseIncome * _monthlyMultiplier(i.payFrequency),
      );
      final totalBills = incomeState.financialCommitments.fold<double>(
        0,
        (sum, c) => sum + c.amount,
      );
      final totalSavings = incomeState.savingsGoals.fold<double>(
        0,
        (sum, g) => sum + g.contribution,
      );
      safeToSpend = monthlyIncome - totalBills - totalSavings;
      breakdownMonthlyIncome = monthlyIncome;
      breakdownBills = totalBills;
      payFrequencyLabel =
          '${incomeState.incomes.first.payFrequency.replaceAll('_', ' ').toLowerCase()} paycheck';
      billsCount = incomeState.financialCommitments.length;
    } else if (setupData.baseIncome.isNotEmpty) {
      final income = double.tryParse(setupData.baseIncome) ?? 0;
      final monthlyIncomeVal =
          income * _monthlyMultiplierFromIndex(setupData.payFrequencyIndex);
      final rent = double.tryParse(setupData.rentAmount) ?? 0;
      final carPayment = double.tryParse(setupData.carPaymentAmount) ?? 0;
      double billsTotal = 0;
      for (final bill in setupData.bills) {
        billsTotal += double.tryParse(bill['amount'] ?? '0') ?? 0;
      }
      double debtsTotal = 0;
      for (final debt in setupData.debts) {
        debtsTotal += double.tryParse(debt['amount'] ?? '0') ?? 0;
      }
      double savingsTotal = 0;
      for (final goal in setupData.savings) {
        savingsTotal += double.tryParse(goal['amount'] ?? '0') ?? 0;
      }
      safeToSpend =
          monthlyIncomeVal -
          rent -
          carPayment -
          billsTotal -
          debtsTotal -
          savingsTotal;
      breakdownMonthlyIncome = monthlyIncomeVal;
      breakdownBills = rent + carPayment + billsTotal + debtsTotal;
      payFrequencyLabel = _payFrequencyLabel(setupData.payFrequencyIndex);
      billsCount = setupData.bills.length + setupData.debts.length;
      debugPrint("safet to spend $safeToSpend");
    } else {
      safeToSpend = 0;
      breakdownMonthlyIncome = 0;
      breakdownBills = 0;
      payFrequencyLabel = 'monthly paycheck';
      billsCount = 0;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLogoText(),
                      SizedBox(height: 4.h),
                      Text(
                        '$greeting, $userName',
                        style: getRegularStyle16_400(
                          fontSize: 14,
                          color: ColorManager.cA87B4D,
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        DateFormat('EEEE, MMMM d').format(now),
                        style: getRegularStyle16_400(
                          fontSize: 12,
                          color: ColorManager.cA87B4D,
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesName.homeSettingsScreen,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: ColorManager.secondaryBackGround,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        IconManager.userIcon,
                        colorFilter: ColorFilter.mode(
                          ColorManager.primaryButton,
                          BlendMode.srcIn,
                        ),
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 300.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: const Alignment(0.0015, 0.0),
                        radius: 0.5,
                        colors: [
                          ColorManager.cE9D6A5,
                          ColorManager.cEADFC6,
                          ColorManager.primaryLight,
                        ],
                        stops: const [0.0, 0.3648, 0.9737],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'SAFE TO SPEND',
                        style: getLightStyle14_400(
                          fontSize: 11,
                          color: ColorManager.gold,
                        ).copyWith(letterSpacing: 1.5),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        incomeState.isLoading
                            ? '...'
                            : '\$${safeToSpend.toStringAsFixed(0)}',
                        style: getMediumStyle18(
                          fontSize: 80,
                          color: ColorManager.c2E1606,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 32.w,
                            height: 1.h,
                            color: ColorManager.cACA49F,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              payFrequencyLabel,
                              style: getLightStyle14_400(
                                color: ColorManager.cA27E5D,
                              ),
                            ),
                          ),
                          Container(
                            width: 32.w,
                            height: 1.h,
                            color: ColorManager.cACA49F,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              Text(
                'Payday Breakdown',
                style: getRegularStyle16_500(
                  fontSize: 16.sp,
                  color: ColorManager.cB8976A,
                ),
              ),
              SizedBox(height: 32.h),

              _buildBreakdownRow(
                "Pay this period",
                "\$${breakdownMonthlyIncome.toStringAsFixed(0)}",
              ),
              SizedBox(height: 16.h),
              _buildBreakdownRow(
                "Bills ($billsCount)",
                "\$${breakdownBills.toStringAsFixed(0)}",
              ),

              SizedBox(height: 20.h),
              Divider(color: ColorManager.cE0D4C2, thickness: 1),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Safe to Spend',
                    style: getMediumStyle18(color: ColorManager.c3B2208),
                  ),
                  Text(
                    incomeState.isLoading
                        ? '...'
                        : '\$${safeToSpend.toStringAsFixed(0)}',
                    style: getMediumStyle18(color: ColorManager.textPrimary),
                  ),
                ],
              ),
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: getRegularStyle16_400(color: ColorManager.cA08060)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: CustomPaint(painter: DottedLinePainter()),
          ),
        ),
        Text(value, style: getRegularStyle16_400(color: ColorManager.c7A5E38)),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = ColorManager.cA08060
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 1.2),
        Offset(startX + dashWidth, size.height / 1.2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
