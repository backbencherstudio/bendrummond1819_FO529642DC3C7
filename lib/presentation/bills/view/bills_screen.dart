import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/bills_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/staggered_fade_slide.dart';
import 'widgets/bills_card.dart';

class BillsScreen extends ConsumerStatefulWidget {
  const BillsScreen({super.key});

  @override
  ConsumerState<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends ConsumerState<BillsScreen>
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
      await ref.read(billsProvider.notifier).fetchBills();
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
    final state = ref.watch(billsProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 20.0.r, left: 20.0.r, top: 20.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bills',
                style: getSemiBoldStyle22(
                  color: ColorManager.textPrimary,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 24.h),
              _BillsSummaryRow(bills: state.bills),
              SizedBox(height: 16.h),
              Expanded(child: _buildBody(state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BillsState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorManager.textPrimary),
      );
    }
    if (state.error != null) {
      return Center(
        child: Text(
          "Error loading bills",
          style: getRegularStyle16_400(color: ColorManager.errorColor),
        ),
      );
    }
    if (state.bills.isEmpty) {
      return Center(
        child: Text(
          "No bills yet",
          style: getRegularStyle16_400(color: ColorManager.brown400),
        ),
      );
    }

    final bills = state.bills;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final bill = bills[index];
        final subtitle = bill.dueDay != null
            ? "Due day ${bill.dueDay}"
            : (bill.frequency ?? "Monthly");

        return StaggeredFadeSlide(
          controller: _controller,
          delay: _delayFor(index, bills.length),
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Dismissible(
              key: ValueKey(bill.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 24.w),
                decoration: BoxDecoration(
                  color: ColorManager.errorColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: ColorManager.whiteColor,
                  size: 24.sp,
                ),
              ),
              onDismissed: (_) => _handleDismiss(bill),
              child: BillCard(
                bill: bill,
                subtitle: subtitle,
                onEditTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.editBillScreen,
                  arguments: bill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleDismiss(FinancialCommitmentData bill) async {
    final success = await ref.read(billsProvider.notifier).deleteBill(bill.id!);
    if (context.mounted) {
      Utils.showToast(
        message: success ? "Bill deleted" : "Failed to delete bill",
        backgroundColor: success
            ? ColorManager.successColor
            : ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
    }
  }
}

/// Top row showing the total monthly bill amount and the "add bill" button.
class _BillsSummaryRow extends StatelessWidget {
  final List<FinancialCommitmentData> bills;

  const _BillsSummaryRow({required this.bills});

  @override
  Widget build(BuildContext context) {
    final total = bills.fold<double>(0, (sum, c) => sum + c.amount);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${total.toStringAsFixed(0)}/month',
          style: getRegularStyle16_400(color: ColorManager.brown400),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, RoutesName.addBillScreen),
          child: Container(
            padding: EdgeInsets.all(6.r),
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
        ),
      ],
    );
  }
}
