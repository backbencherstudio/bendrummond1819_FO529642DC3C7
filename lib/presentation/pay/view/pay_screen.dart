import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/add_edit_income_sheet.dart';
import 'widgets/pay_commitments_section.dart';
import 'widgets/pay_incomes_section.dart';
import 'widgets/safe_to_spend.dart';

class PayScreen extends ConsumerStatefulWidget {
  const PayScreen({super.key});

  @override
  ConsumerState<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends ConsumerState<PayScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    Future.microtask(() async {
      await ref.read(incomesProvider.notifier).fetchIncomes();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incomesProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 20.0.r, left: 20.0.r, top: 20.0.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay & Income',
                  style: getSemiBoldStyle22(
                    color: ColorManager.textPrimary,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 24.h),
                SafeToSpendCard(safeToSpend: state.safeToSpend),
                SizedBox(height: 24.h),
                if (state.isLoading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: CircularProgressIndicator(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                  )
                else
                  _buildContent(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(IncomesState state) {
    final incomes = state.incomes;
    final commitments = state.financialCommitments;
    final total = incomes.length + commitments.length + 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PayIncomesSection(
          controller: _controller,
          incomes: incomes,
          totalItems: total,
          startIndex: 0,
          onEdit: (income) => _showAddEditSheet(existing: income),
        ),
        SizedBox(height: 24.h),
        PayCommitmentsSection(
          controller: _controller,
          commitments: commitments,
          totalItems: total,
          startIndex: incomes.isEmpty ? 1 : incomes.length,
          onAdd: () => _showAddEditSheet(),
        ),
      ],
    );
  }

  void _showAddEditSheet({IncomeData? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => AddEditIncomeSheet(existing: existing),
    );
  }
}
