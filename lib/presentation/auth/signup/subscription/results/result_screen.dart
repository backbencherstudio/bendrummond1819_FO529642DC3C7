import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/image_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  double _monthlyIncome = 0;
  double _rent = 0;
  double _carPayment = 0;
  double _billsTotal = 0;
  int _billsCount = 0;
  double _debtsTotal = 0;
  int _debtsCount = 0;
  double _savingsTotal = 0;
  int _savingsCount = 0;

  double get _totalDeductions => _rent + _carPayment + _billsTotal + _debtsTotal;
  double get _monthlyRemaining => _monthlyIncome - _totalDeductions - _savingsTotal;
  double get _weeklySafeToSpend => _monthlyRemaining / 4.33;

  void _computeValues() {
    final data = ref.read(setupDataProvider);
    final income = double.tryParse(data.baseIncome) ?? 0;
    final freqIndex = data.payFrequencyIndex;
    final monthlyMultiplier = _monthlyMultiplier(freqIndex);
    _monthlyIncome = income * monthlyMultiplier;
    _rent = double.tryParse(data.rentAmount) ?? 0;
    _carPayment = double.tryParse(data.carPaymentAmount) ?? 0;

    _billsTotal = 0;
    _billsCount = data.bills.length;
    for (final bill in data.bills) {
      _billsTotal += double.tryParse(bill['amount'] ?? '0') ?? 0;
    }

    _debtsTotal = 0;
    _debtsCount = data.debts.length;
    for (final debt in data.debts) {
      _debtsTotal += double.tryParse(debt['amount'] ?? '0') ?? 0;
    }

    _savingsTotal = 0;
    _savingsCount = data.savings.length;
    for (final goal in data.savings) {
      _savingsTotal += double.tryParse(goal['amount'] ?? '0') ?? 0;
    }
  }

  double _monthlyMultiplier(int index) {
    switch (index) {
      case 0: return 4.33; // WEEKLY
      case 1: return 2.17; // EVERY_2_WEEKS
      case 2: return 2;    // TWICE_A_MONTH
      case 3: return 1;    // MONTHLY
      default: return 1;
    }
  }

  String _fmt(double value) {
    return '\$${value.toStringAsFixed(0)}';
  }

  @override
  void initState() {
    super.initState();
    _computeValues();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(setupDataProvider);
    _computeValues();

    final safeToSpend = _weeklySafeToSpend;

    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 380.h,
              child: Image.asset(ImageManager.teaCup, fit: BoxFit.fill),
            ),
            Transform.translate(
              offset: Offset(0, -45.h),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0.w,
                  vertical: 12.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Personalized",
                      style: getRegularStyle16_400(
                        color: ColorManager.goldAccent,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Stability profile.",
                      style: getBoldStyle24(color: ColorManager.brown400),
                    ),
                    Text(
                      _fmt(safeToSpend),
                      style: getRegularStyle16_600(
                        color: ColorManager.accentBrown,
                        fontSize: 56.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "safe to spend every week",
                      style: getLightStyle14_400(color: ColorManager.brown300),
                    ),
                    SizedBox(height: 16.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.backgroundSecondary,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: ColorManager.brown400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            safeToSpend > 0
                                ? "You have breathing room"
                                : "Budget needs attention",
                            style: getLightStyle14_400(
                              color: ColorManager.brown400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),
                    Text(
                      "Close is perfect. We'll adjust later.",
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFE0D9D1),
                          width: 1.w,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildCardRow1("Take-home pay", "+${_fmt(_monthlyIncome)}"),
                          Divider(
                            thickness: 1,
                            color: ColorManager.backgroundPressed100,
                          ),
                          if (_rent > 0) ...[
                            _buildCardRow2("Rent / mortgage", "-${_fmt(_rent)}"),
                            SizedBox(height: 12),
                          ],
                          if (_carPayment > 0) ...[
                            _buildCardRow2("Car payment", "-${_fmt(_carPayment)}"),
                            SizedBox(height: 12),
                          ],
                          if (_billsCount > 0) ...[
                            _buildCardRow2("Bills ($_billsCount)", "-${_fmt(_billsTotal)}"),
                            SizedBox(height: 12),
                          ],
                          if (_debtsCount > 0) ...[
                            _buildCardRow2("Debts ($_debtsCount)", "-${_fmt(_debtsTotal)}"),
                            SizedBox(height: 12),
                          ],
                          if (_savingsCount > 0) ...[
                            _buildCardRow2("Savings goals ($_savingsCount)", "-${_fmt(_savingsTotal)}"),
                            SizedBox(height: 12),
                          ],
                          if (_rent <= 0 && _carPayment <= 0 &&
                              _billsCount <= 0 && _debtsCount <= 0 &&
                              _savingsCount <= 0)
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Text(
                                "No expenses entered yet",
                                style: getRegularStyle16_400(
                                  color: ColorManager.brown400,
                                ),
                              ),
                            ),
                          Divider(
                            thickness: 1,
                            color: ColorManager.backgroundPressed100,
                          ),
                          _buildCardRow1("Safe to spend", _fmt(safeToSpend)),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      "Every bill, debt payment, and savings goal you entered is already subtracted. What's left is yours to spend — without worrying whether you've covered the essentials.",
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    PrimaryButton(
                      title: 'Start tracking',
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesName.bottomNavRoute,
                          (predicate) => false,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    CustomOutlinedButton(
                      title: 'Adjust something',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardRow1(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getRegularStyle16_500(color: ColorManager.textPrimary),
        ),
        Text(
          value,
          style: getRegularStyle16_500(color: ColorManager.textPrimary),
        ),
      ],
    );
  }

  Widget _buildCardRow2(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getRegularStyle16_400(color: ColorManager.brown400),
        ),
        Text(
          value,
          style: getRegularStyle16_400(color: ColorManager.brown400),
        ),
      ],
    );
  }
}
