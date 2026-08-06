import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/balances_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditDebtSheet extends ConsumerStatefulWidget {
  final FinancialCommitmentData? existing;

  const AddEditDebtSheet({super.key, this.existing});

  bool get isEditing => existing != null;

  @override
  ConsumerState<AddEditDebtSheet> createState() => _AddEditDebtSheetState();
}

class _AddEditDebtSheetState extends ConsumerState<AddEditDebtSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _dueDayController;
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _nameController = TextEditingController(text: existing?.name ?? '');
    _amountController = TextEditingController(
      text: existing != null ? existing.amount.toStringAsFixed(0) : '',
    );
    _dueDayController = TextEditingController(
      text: existing?.dueDay?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dueDayController.dispose();
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
              widget.isEditing ? 'Edit debt' : 'Add debt',
              style: getSemiBoldStyle22(
                color: ColorManager.textPrimary,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 20.h),

            _LabeledField(
              label: 'Name',
              controller: _nameController,
              hintText: 'e.g. Credit card',
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            SizedBox(height: 12.h),

            _LabeledField(
              label: 'Amount',
              controller: _amountController,
              hintText: 'e.g. 25',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (double.tryParse(v) == null) return 'Invalid number';
                return null;
              },
            ),
            SizedBox(height: 12.h),

            _LabeledField(
              label: 'Due day (optional)',
              controller: _dueDayController,
              hintText: 'e.g. 6',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final day = int.tryParse(v);
                if (day == null || day < 1 || day > 31) return 'Enter 1-31';
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

    final name = _nameController.text.trim();
    final amount = double.parse(_amountController.text.trim());
    final dueDayText = _dueDayController.text.trim();
    final dueDay = dueDayText.isNotEmpty ? int.parse(dueDayText) : null;

    bool success = false;
    try {
      if (widget.isEditing) {
        success = await ref
            .read(balancesProvider.notifier)
            .updateDebt(
              id: widget.existing!.id!,
              name: name,
              amount: amount,
              dueDay: dueDay,
            );
      } else {
        success = await ref
            .read(balancesProvider.notifier)
            .addDebt(name: name, amount: amount, dueDay: dueDay);
      }
    } catch (_) {
      success = false;
    } finally {
      if (success) {
        ref.read(incomesProvider.notifier).fetchIncomes();
      }
    }

    if (!mounted) return;
    Navigator.pop(context);

    Utils.showToast(
      message: success
          ? (widget.isEditing ? "Debt updated" : "Debt added")
          : "Failed to save debt",
      backgroundColor: success
          ? ColorManager.successColor
          : ColorManager.errorColor,
      textColor: ColorManager.whiteColor,
    );
  }
}

/// Small internal helper to avoid repeating the label + TextFormField
/// pattern three times in the form above.
class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _LabeledField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: getRegularStyle16_400(color: ColorManager.brown400)),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
