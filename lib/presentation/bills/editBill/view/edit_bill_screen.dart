import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/bills_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBillScreen extends ConsumerStatefulWidget {
  const EditBillScreen({super.key});

  @override
  ConsumerState<EditBillScreen> createState() => _EditBillScreenState();
}

class _EditBillScreenState extends ConsumerState<EditBillScreen> {
  FinancialCommitmentData? _bill;
  bool _isRecurring = false;
  int _selectedFrequency = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDayController = TextEditingController();
  bool _isSubmitting = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is FinancialCommitmentData) {
        _bill = args;
        _nameController.text = _bill!.name;
        _amountController.text = _bill!.amount.toStringAsFixed(0);
        _dueDayController.text = _bill!.dueDay?.toString() ?? '';
        _isRecurring = _bill!.isRecurring;
        if (_bill!.dueDay != null) {
          if (_bill!.dueDay! <= 10) {
            _selectedFrequency = 0;
          } else if (_bill!.dueDay! <= 20) {
            _selectedFrequency = 1;
          } else {
            _selectedFrequency = 2;
          }
        }
        _initialized = true;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dueDayController.dispose();
    super.dispose();
  }

  String _categoryFromFrequency() {
    switch (_selectedFrequency) {
      case 0:
        return 'HOUSING';
      case 1:
        return 'REGULAR_BILL';
      case 2:
        return 'REGULAR_BILL';
      default:
        return 'REGULAR_BILL';
    }
  }

  Future<void> _submitBill() async {
    if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
      Utils.showToast(
        message: "Please fill in all required fields",
        backgroundColor: ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
      return;
    }

    if (_bill?.id == null) return;

    setState(() => _isSubmitting = true);

    final success = await ref.read(billsProvider.notifier).updateBill(
          id: _bill!.id!,
          category: _categoryFromFrequency(),
          name: _nameController.text,
          amount: double.tryParse(_amountController.text) ?? 0,
          dueDay: int.tryParse(_dueDayController.text),
          isRecurring: _isRecurring,
        );

    if (mounted) {
      Utils.showToast(
        message: success ? "Bill updated successfully" : "Failed to update bill",
        backgroundColor: success ? ColorManager.successColor : ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
      if (success) {
        Navigator.pop(context);
      }
    }

    if (mounted) setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.backgroundPressed100,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Edit bill',
                    style: getSemiBoldStyle22(
                      color: ColorManager.textPrimary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              _buildLabel("Bill Name"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: "Electricity Bill", controller: _nameController),
              SizedBox(height: 12.h),
              _buildLabel("Amount"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: '60',
                controller: _amountController,
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _isRecurring,
                      activeColor: ColorManager.brown,
                      side: BorderSide(color: ColorManager.brown, width: 1.5),
                      onChanged: (val) => setState(() => _isRecurring = val!),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Set as Weekly/Monthly Payment",
                    style: getRegularStyle16_400(
                      color: ColorManager.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _buildLabel("Frequency"),
              SizedBox(height: 6.h),
              _buildFrequencyCard(0, "Beginning of month", "1st - 10th"),
              SizedBox(height: 16.h),
              _buildFrequencyCard(1, "Middle of month", "11th - 20th"),
              SizedBox(height: 16.h),
              _buildFrequencyCard(2, "End of month", "21st - 31st"),
              SizedBox(height: 12.h),
              _buildLabel("Due day"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: "4", controller: _dueDayController),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      title: "Cancel",
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _isSubmitting
                        ? Center(child: CircularProgressIndicator(color: ColorManager.textPrimary))
                        : PrimaryButton(title: "Save", onTap: _submitBill),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300, fontSize: 14),
    );
  }

  Widget _buildFrequencyCard(int index, String title, String subtitle) {
    bool isSelected = _selectedFrequency == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFrequency = index),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: ColorManager.secondaryBackGround,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? ColorManager.brown500 : ColorManager.backgroundPressed100,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getMediumStyle18(color: ColorManager.grayBlack400),
                ),
                Text(
                  subtitle,
                  style: getMediumStyle18(color: ColorManager.brown300, fontSize: 12),
                ),
              ],
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: ColorManager.primaryButton,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, size: 8.sp, color: ColorManager.whiteColor),
              ),
          ],
        ),
      ),
    );
  }
}
