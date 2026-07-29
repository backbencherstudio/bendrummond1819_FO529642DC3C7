import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resource/constants/income_constants.dart';

class AddEditIncomeSheet extends ConsumerStatefulWidget {
  final IncomeData? existing;

  const AddEditIncomeSheet({super.key, this.existing});

  bool get isEditing => existing != null;

  @override
  ConsumerState<AddEditIncomeSheet> createState() => _AddEditIncomeSheetState();
}

class _AddEditIncomeSheetState extends ConsumerState<AddEditIncomeSheet> {
  late final TextEditingController _amountController;
  late String _selectedType;
  late String _selectedFreq;
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _selectedType = existing?.incomeType ?? incomeTypes[0];
    _selectedFreq = existing?.payFrequency ?? payFrequencies[0];
    _amountController = TextEditingController(
      text: existing != null ? existing.baseIncome.toStringAsFixed(0) : '',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isEditing ? 'Edit income' : 'Add income',
              style: getSemiBoldStyle22(
                color: ColorManager.textPrimary,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              'Income type',
              style: getRegularStyle16_400(color: ColorManager.brown400),
            ),
            SizedBox(height: 6.h),
            DropdownButtonFormField<String>(
              initialValue: _selectedType,
              items: incomeTypes
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text(formatEnumLabel(t)),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() => _selectedType = v);
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
              style: getRegularStyle16_400(color: ColorManager.brown400),
            ),
            SizedBox(height: 6.h),
            DropdownButtonFormField<String>(
              initialValue: _selectedFreq,
              items: payFrequencies
                  .map(
                    (f) => DropdownMenuItem(
                      value: f,
                      child: Text(formatEnumLabel(f)),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() => _selectedFreq = v);
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
              style: getRegularStyle16_400(color: ColorManager.brown400),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _amountController,
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
                onPressed: _submitting ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _submitting
                    ? SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        widget.isEditing ? 'Update' : 'Add',
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
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final amount = double.parse(_amountController.text.trim());

    bool success;
    try {
      if (widget.isEditing) {
        success = await ref
            .read(incomesProvider.notifier)
            .updateIncome(
              id: widget.existing!.id!,
              incomeType: _selectedType,
              payFrequency: _selectedFreq,
              baseIncome: amount,
            );
      } else {
        success = await ref
            .read(incomesProvider.notifier)
            .addIncome(
              incomeType: _selectedType,
              payFrequency: _selectedFreq,
              baseIncome: amount,
            );
      }
    } catch (_) {
      success = false;
    }

    if (!mounted) return;
    Navigator.pop(context);

    Utils.showToast(
      message: success
          ? (widget.isEditing ? "Income updated" : "Income added")
          : "Failed to save income",
      backgroundColor: success
          ? ColorManager.successColor
          : ColorManager.errorColor,
      textColor: ColorManager.whiteColor,
    );
  }
}
