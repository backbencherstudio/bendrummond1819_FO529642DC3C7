import 'dart:ui';

import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const List<String> _incomeTypes = ['SAME_EVERY_PAYCHECK', 'FIXED', 'VARIABLE'];

const List<String> _frequencies = [
  'WEEKLY',
  'EVERY_2_WEEKS',
  'TWICE_A_MONTH',
  'MONTHLY',
];

String _formatLabel(String value) {
  return value
      .replaceAll('_', ' ')
      .split(' ')
      .map(
        (w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}'
            : '',
      )
      .join(' ');
}

class PayScreen extends ConsumerStatefulWidget {
  const PayScreen({super.key});

  @override
  ConsumerState<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends ConsumerState<PayScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(incomesProvider.notifier).fetchIncomes());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incomesProvider);
    debugPrint("Pay screen $state");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0.r,
            right: 20.0.r,
            top: 32.r,
            bottom: 100.h,
          ),
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

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: ColorManager.backgroundPressed100,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Safe to spend',
                            style: getRegularStyle16_400(
                              color: ColorManager.brown300,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            '\$${state.safeToSpend.toStringAsFixed(0)}',
                            style: getMediumStyle18(
                              color: ColorManager.textPrimary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          'Updates when you save',
                          textAlign: TextAlign.right,
                          style: getRegularStyle16_400(
                            color: ColorManager.brown300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                else ...[
                  Text(
                    'Your incomes',
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),
                  SizedBox(height: 12.h),

                  if (state.incomes.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Text(
                        "No incomes yet",
                        style: getRegularStyle16_400(
                          color: ColorManager.brown400,
                        ),
                      ),
                    )
                  else
                    ...List.generate(state.incomes.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildIncomeCard(state.incomes[i]),
                      );
                    }),

                  SizedBox(height: 24.h),

                  Text(
                    'Your pay',
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),
                  SizedBox(height: 12.h),

                  if (state.financialCommitments.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Text(
                        "No commitments yet",
                        style: getRegularStyle16_400(
                          color: ColorManager.brown400,
                        ),
                      ),
                    )
                  else
                    ...List.generate(state.financialCommitments.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildCommitmentCard(
                          state.financialCommitments[i],
                        ),
                      );
                    }),

                  SizedBox(height: 16.h),

                  GestureDetector(
                    onTap: () => _showAddEditSheet(),
                    child: CustomPaint(
                      painter: DashedRectPainter(
                        color: ColorManager.primaryButton,
                      ),
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
                              'Add an income',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeCard(IncomeData income) {
    return GestureDetector(
      onTap: () => _showAddEditSheet(existing: income),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorManager.secondaryBackGround,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorManager.borderE0D9D1, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatLabel(income.incomeType),
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _formatLabel(income.payFrequency),
                    style: getRegularStyle16_400(
                      color: ColorManager.brown400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${income.baseIncome.toStringAsFixed(0)}',
              style: getRegularStyle16_400(
                color: ColorManager.brown400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitmentCard(FinancialCommitmentData c) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.borderE0D9D1, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.name,
                  style: getRegularStyle16_400(
                    color: ColorManager.brown400,
                    fontSize: 18,
                  ),
                ),
                if (c.dueDay != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Due day ${c.dueDay}',
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
            '\$${c.amount.toStringAsFixed(0)}',
            style: getRegularStyle16_400(
              color: ColorManager.brown400,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditSheet({IncomeData? existing}) {
    final isEditing = existing != null;
    final formKey = GlobalKey<FormState>();

    String selectedType = existing?.incomeType ?? _incomeTypes[0];
    String selectedFreq = existing?.payFrequency ?? _frequencies[0];
    final amountController = TextEditingController(
      text: existing != null ? existing.baseIncome.toStringAsFixed(0) : '',
    );

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
                      isEditing ? 'Edit income' : 'Add income',
                      style: getSemiBoldStyle22(
                        color: ColorManager.textPrimary,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Income type',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      items: _incomeTypes
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: Text(_formatLabel(t)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setSheetState(() => selectedType = v);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Pay frequency',
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    DropdownButtonFormField<String>(
                      initialValue: selectedFreq,
                      items: _frequencies
                          .map(
                            (f) => DropdownMenuItem(
                              value: f,
                              child: Text(_formatLabel(f)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setSheetState(() => selectedFreq = v);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
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
                        hintText: 'e.g. 120000',
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

                                final amount = double.parse(
                                  amountController.text.trim(),
                                );

                                bool success;
                                if (isEditing) {
                                  success = await ref
                                      .read(incomesProvider.notifier)
                                      .updateIncome(
                                        id: existing.id!,
                                        incomeType: selectedType,
                                        payFrequency: selectedFreq,
                                        baseIncome: amount,
                                      );
                                } else {
                                  success = await ref
                                      .read(incomesProvider.notifier)
                                      .addIncome(
                                        incomeType: selectedType,
                                        payFrequency: selectedFreq,
                                        baseIncome: amount,
                                      );
                                }

                                if (ctx.mounted) {
                                  Navigator.pop(ctx);
                                }
                                if (context.mounted) {
                                  Utils.showToast(
                                    message: success
                                        ? (isEditing
                                              ? "Income updated"
                                              : "Income added")
                                        : "Failed to save income",
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
