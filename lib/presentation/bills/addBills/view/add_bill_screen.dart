import 'package:bendrummond1819_fo529642dc3c7/core/network/api_clients.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/repositories/setup_repository.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/sources/remote/setup_api_service.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/bills_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resource/constants/icon_manager.dart';
import '../../../widgets/custom_date_picker_field.dart';

class AddBillScreen extends ConsumerStatefulWidget {
  const AddBillScreen({super.key});

  @override
  ConsumerState<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends ConsumerState<AddBillScreen> {
  bool _isRecurring = false;
  int _selectedFrequency = 0;
  String selectedFrequency="";
  bool isFrequencyExpanded=false;
  TextEditingController frequentlyController=TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDayController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dueDayController.dispose();
    frequentlyController.dispose();
    super.dispose();
  }

  String _categoryFromFrequency() {
    switch (_selectedFrequency) {
      case 0: return 'HOUSING';
      case 1: return 'REGULAR_BILL';
      case 2: return 'REGULAR_BILL';
      default: return 'REGULAR_BILL';
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

    setState(() => _isSubmitting = true);

    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );

      final success = await repository.addBill(
        category: _categoryFromFrequency(),
        name: _nameController.text,
        amount: double.tryParse(_amountController.text) ?? 0,
        dueDay: int.tryParse(_dueDayController.text),
        frequency: 'MONTHLY',
        isRecurring: _isRecurring,
      );

      if (success && mounted) {
        Utils.showToast(
          message: "Bill added successfully",
          backgroundColor: ColorManager.successColor,
          textColor: ColorManager.whiteColor,
        );
        ref.invalidate(billsProvider);
        Navigator.pop(context);
      } else if (mounted) {
        Utils.showToast(
          message: "Failed to add bill",
          backgroundColor: ColorManager.errorColor,
          textColor: ColorManager.whiteColor,
        );
      }
    } catch (e) {
      if (mounted) {
        Utils.showToast(
          message: "Error: ${e.toString()}",
          backgroundColor: ColorManager.errorColor,
          textColor: ColorManager.whiteColor,
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
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
              // Top Bar: Back Button + Title
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.backgroundPressed100,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Add bill',
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
                prefixIcon: SvgPicture.asset(IconManager.dollar),
                controller: _amountController,
              ),

              SizedBox(height: 6.h),

              // Checkbox Row
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

              // Frequency Selection Cards
              _buildFrequencyCard(0, "Beginning of month", "1st - 10th"),
              SizedBox(height: 16.h),
              _buildFrequencyCard(1, "Middle of month", "11th - 20th"),
              SizedBox(height: 16.h),
              _buildFrequencyCard(2, "End of month", "21st - 31st"),

              SizedBox(height: 6.h),

              CustomDatePickerField(
                hintText: "Select Frequency Date",
                controller: frequentlyController,
                onDateSelected: () {
                  setState(() {
                    selectedFrequency = frequentlyController.text;
                    isFrequencyExpanded = false;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please pick a date';
                  }
                  return null;
                },
              ),

              SizedBox(height: 12.h),
              _buildLabel("Due day"),
              SizedBox(height: 6.h),
              CustomFromField(hintText: "4", controller: _dueDayController),

              SizedBox(height: 24.h),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(title: "Delete", onTap: () {
                      Navigator.pop(context);
                    }),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _isSubmitting
                        ? Center(child: CircularProgressIndicator(color: ColorManager.textPrimary))
                        : PrimaryButton(title: "Add Bill", onTap: _submitBill),
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
            color: isSelected
                ? ColorManager.brown500
                : ColorManager.backgroundPressed100,
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
                  style: getMediumStyle18(
                    color: ColorManager.brown300,
                    fontSize: 12,
                  ),
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
                child: SvgPicture.asset(
                  IconManager.tikMark,
                  width: 8.w,
                  height: 8.h,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDateDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorManager.backgroundPressed100),
      ),
      child: Row(
        children: [
          SvgPicture.asset(IconManager.calendar),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "Custom date",
              style: getRegularStyle16_400(color: ColorManager.brown400),
            ),
          ),
          SvgPicture.asset(IconManager.arrowDown),
        ],
      ),
    );
  }
}
