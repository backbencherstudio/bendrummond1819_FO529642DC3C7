import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/balances_provider.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalancesScreen extends ConsumerStatefulWidget {
  const BalancesScreen({super.key});

  @override
  ConsumerState<BalancesScreen> createState() => _BalancesScreenState();
}

class _BalancesScreenState extends ConsumerState<BalancesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(balancesProvider.notifier).fetchDebts());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(balancesProvider);
    final debts = state.debts;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.r, right: 20.0.r, top: 32.r, bottom: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balances',
                style: getSemiBoldStyle22(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 24.h),

              Expanded(
                child: state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.textPrimary,
                        ),
                      )
                    : debts.isEmpty
                        ? Center(
                            child: Text(
                              "No balances yet",
                              style: getRegularStyle16_400(
                                color: ColorManager.brown400,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: debts.length,
                            separatorBuilder: (_, _) => SizedBox(height: 12.h),
                            itemBuilder: (_, i) => _buildDebtCard(debts[i]),
                          ),
              ),

              SizedBox(height: 16.h),

              GestureDetector(
                onTap: () => _showAddEditSheet(),
                child: CustomPaint(
                  painter: DashedRectPainter(color: ColorManager.primaryButton),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDebtCard(FinancialCommitmentData debt) {
    return GestureDetector(
      onTap: () => _showAddEditSheet(existing: debt),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorManager.secondaryBackGround,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorManager.borderE0D9D1,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    debt.name,
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 18,
                    ),
                  ),
                  if (debt.dueDay != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      'Due day ${debt.dueDay}',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              '\$${debt.amount.toStringAsFixed(0)}',
              style: getRegularStyle16_400(
                color: ColorManager.brown400,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 18.w),
            GestureDetector(
              onTap: () => _deleteDebt(debt.id),
              child: Icon(
                Icons.close,
                color: ColorManager.primaryButton,
                size: 20.sp,
              ),
            ),
          ],
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
        backgroundColor:
            success ? ColorManager.successColor : ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
    }
  }

  void _showAddEditSheet({FinancialCommitmentData? existing}) {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final amountController = TextEditingController(
      text: existing != null ? existing.amount.toStringAsFixed(0) : '',
    );
    final dueDayController = TextEditingController(
      text: existing?.dueDay?.toString() ?? '',
    );
    final isEditing = existing != null;
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        bool submitting = false;

        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24.h,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? 'Edit debt' : 'Add debt',
                      style: getSemiBoldStyle22(
                        color: ColorManager.textPrimary,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Name',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Credit card',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Amount',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'e.g. 25',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Due day (optional)',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: dueDayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'e.g. 6',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return null;
                        final day = int.tryParse(v);
                        if (day == null || day < 1 || day > 31) {
                          return 'Enter 1-31';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: submitting
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;
                                setSheetState(() => submitting = true);

                                final name = nameController.text.trim();
                                final amount =
                                    double.parse(amountController.text.trim());
                                final dueDay = dueDayController.text.trim();
                                final dueDayParsed =
                                    dueDay.isNotEmpty ? int.parse(dueDay) : null;

                                bool success;
                                if (isEditing) {
                                  success = await ref
                                      .read(balancesProvider.notifier)
                                      .updateDebt(
                                        id: existing.id!,
                                        name: name,
                                        amount: amount,
                                        dueDay: dueDayParsed,
                                      );
                                } else {
                                  success = await ref
                                      .read(balancesProvider.notifier)
                                      .addDebt(
                                        name: name,
                                        amount: amount,
                                        dueDay: dueDayParsed,
                                      );
                                }

                                if (ctx.mounted) {
                                  Navigator.pop(ctx);
                                }
                                if (context.mounted) {
                                  Utils.showToast(
                                    message: success
                                        ? (isEditing
                                            ? "Debt updated"
                                            : "Debt added")
                                        : "Failed to save debt",
                                    backgroundColor: success
                                        ? ColorManager.successColor
                                        : ColorManager.errorColor,
                                    textColor: ColorManager.whiteColor,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: submitting
                            ? SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isEditing ? 'Update' : 'Add',
                                style: getMediumStyle18(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color;
  DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ),
    );

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (startX < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(startX, startX + dashWidth),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
