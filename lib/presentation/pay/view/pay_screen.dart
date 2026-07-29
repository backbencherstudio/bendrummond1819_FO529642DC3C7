import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/stagger_delay_for.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/staggered_fade_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/add_edit_income_sheet.dart';
import 'widgets/add_income_button.dart';
import 'widgets/commitment_card.dart';
import 'widgets/empty_section_text.dart';
import 'widgets/income_card.dart';
import 'widgets/safe_to_spend.dart';
import 'widgets/section_label.dart';

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
                  ..._buildContent(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(int index, int total, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: StaggeredFadeSlide(
        controller: _controller,
        delay: staggerDelayFor(index, total),
        child: child,
      ),
    );
  }

  List<Widget> _buildContent(IncomesState state) {
    final incomes = state.incomes;
    final commitments = state.financialCommitments;
    final total = incomes.length + commitments.length + 1;

    int idx = 0;
    return [
      const SectionLabel('Your incomes'),
      SizedBox(height: 12.h),
      if (incomes.isEmpty)
        _item(idx++, total, const EmptySectionText('No incomes yet'))
      else
        ...incomes.map((income) => _item(idx++, total, IncomeCard(
              income: income,
              onTap: () => _showAddEditSheet(existing: income),
            ))),
      SizedBox(height: 24.h),
      const SectionLabel('Your pay'),
      SizedBox(height: 12.h),
      if (commitments.isEmpty)
        _item(idx++, total, const EmptySectionText('No commitments yet'))
      else
        ...commitments.map((c) => _item(idx++, total, CommitmentCard(commitment: c))),
      SizedBox(height: 16.h),
      _item(idx++, total, AddIncomeButton(onTap: () => _showAddEditSheet())),
    ];
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

