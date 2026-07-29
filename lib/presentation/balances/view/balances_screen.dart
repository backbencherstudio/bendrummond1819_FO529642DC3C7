import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/balances_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/staggered_fade_slide.dart';
import 'add_debt_sheet.dart';
import 'dashed_rect_painter.dart' show DashedRectPainter;
import 'debt_card.dart';

class BalancesScreen extends ConsumerStatefulWidget {
  const BalancesScreen({super.key});

  @override
  ConsumerState<BalancesScreen> createState() => _BalancesScreenState();
}

class _BalancesScreenState extends ConsumerState<BalancesScreen>
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
      await ref.read(balancesProvider.notifier).fetchDebts();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _delayFor(int index, int itemCount) {
    final step = itemCount > 0 ? (0.5 / itemCount).clamp(0.0, 0.08) : 0.08;
    return (index * step).clamp(0.0, 0.6);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(balancesProvider);
    final debts = state.debts;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0.r,
            right: 20.0.r,
            top: 32.r,
            bottom: 20.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balances',
                style: getSemiBoldStyle22(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 24.h),

              Expanded(child: _buildBody(state.isLoading, debts)),

              SizedBox(height: 16.h),

              _AddDebtButton(onTap: () => _showAddEditSheet()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(bool isLoading, List<FinancialCommitmentData> debts) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorManager.textPrimary),
      );
    }
    if (debts.isEmpty) {
      return Center(
        child: Text(
          "No balances yet",
          style: getRegularStyle16_400(color: ColorManager.brown400),
        ),
      );
    }
    return ListView.separated(
      itemCount: debts.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, i) => StaggeredFadeSlide(
        controller: _controller,
        delay: _delayFor(i, debts.length),
        child: DebtCard(
          debt: debts[i],
          onTap: () => _showAddEditSheet(existing: debts[i]),
          onDelete: () => _deleteDebt(debts[i].id),
        ),
      ),
    );
  }

  Future<void> _deleteDebt(String? id) async {
    if (id == null) return;
    final success = await ref.read(balancesProvider.notifier).deleteDebt(id);
    if (context.mounted) {
      Utils.showToast(
        message: success ? "Debt deleted" : "Failed to delete debt",
        backgroundColor: success
            ? ColorManager.successColor
            : ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
    }
  }

  void _showAddEditSheet({FinancialCommitmentData? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => AddEditDebtSheet(existing: existing),
    );
  }
}

/// The dashed "Add a debt payment" call-to-action row.
class _AddDebtButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddDebtButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DashedRectPainter(color: ColorManager.primaryButton),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorManager.backgroundCard,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: ColorManager.primaryButton,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                'Add a debt payment',
                style: getRegularStyle16_400(
                  color: ColorManager.brown400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

