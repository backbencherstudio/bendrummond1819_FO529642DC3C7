import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/viewmodel/home_riverpod.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/home_header.dart';
import '../widgets/payday_breakdown_section.dart';
import '../widgets/safe_to_spend_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(incomesProvider.notifier).fetchIncomes();
      ref.read(userProvider.notifier).loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final incomeState = ref.watch(incomesProvider);
    final userState = ref.watch(userProvider);
    final summary = _viewModel.compute(
      incomeState: incomeState,
      setupData: ref.watch(setupDataProvider),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeHeader(
                greeting: _viewModel.greeting(),
                userName: userState.user?.name ?? 'there',
              ),
              SizedBox(height: 32.h),
              SafeToSpendCard(
                isLoading: incomeState.isLoading,
                safeToSpend: summary.safeToSpend,
                payFrequencyLabel: summary.payFrequencyLabel,
              ),
              SizedBox(height: 32.h),
              PaydayBreakdownSection(
                isLoading: incomeState.isLoading,
                monthlyIncome: summary.monthlyIncome,
                bills: summary.bills,
                billsCount: summary.billsCount,
                safeToSpend: summary.safeToSpend,
              ),
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }
}
