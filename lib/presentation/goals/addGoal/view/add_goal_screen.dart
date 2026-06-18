import 'package:bendrummond1819_fo529642dc3c7/core/network/api_clients.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/repositories/setup_repository.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/sources/remote/setup_api_service.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/setup_data_api_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddGoalScreen extends ConsumerStatefulWidget {
  const AddGoalScreen({super.key});

  @override
  ConsumerState<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends ConsumerState<AddGoalScreen> {
  final savingNameController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isSubmitting = false;
  String _selectedFrequency = "Per month";

  @override
  void dispose() {
    savingNameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submitGoal() async {
    if (savingNameController.text.isEmpty || _amountController.text.isEmpty) {
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

      final frequency = _selectedFrequency == "Per month"
          ? "MONTHLY"
          : "WEEKLY";

      final success = await repository.addNewGoal(
        goalName: savingNameController.text,
        targetAmount: double.tryParse(_amountController.text) ?? 0,
        contribution: double.tryParse(_amountController.text) ?? 0,
        frequency: frequency,
      );

      print(success);
      if (success && mounted) {
        Utils.showToast(
          message: "Goal Added",
          backgroundColor: ColorManager.successColor,
          textColor: ColorManager.whiteColor,
        );
        ref.read(setupApiDataProvider.notifier).refresh();
        Navigator.pop(context);
      } else if (mounted) {
        Utils.showToast(
          message: "Failed to add goal",
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
              Row(
                spacing: 12.w,
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.customOutlineButtonBorder,
                  ),
                  Text(
                    "Add goal",
                    style: getSemiBoldStyle22(color: ColorManager.textPrimary),
                  ),
                ],
              ),

              SizedBox(height: 35.h),

              // ========== Saving for Section ================
              _buildLabel("What are you saving for?"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: 'Buy a Iphone 17 Pro',
                controller: savingNameController,
              ),

              SizedBox(height: 6.h),

              // Suggestion Chips
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildSuggestionChip("Emergency fund"),
                  _buildSuggestionChip("Vacation"),
                  _buildSuggestionChip("New car"),
                  _buildSuggestionChip("Down payment"),
                  _buildSuggestionChip("Holiday gifts"),
                ],
              ),

              SizedBox(height: 12.h),

              // ===================== Amount ========================
              _buildLabel("Amount"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: '60',
                prefixIcon: SvgPicture.asset(IconManager.dollar),
                controller: _amountController,
              ),

              SizedBox(height: 12.h),

              // ================ Frequency Section ===================
              _buildLabel("Frequency"),
              SizedBox(height: 6.h),
              _buildDropdownField(_selectedFrequency),
              SizedBox(height: 24.h),
              // ================ Add Goal Button =====================
              _isSubmitting
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.textPrimary,
                      ),
                    )
                  : PrimaryButton(title: 'Add Goal', onTap: _submitGoal),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========== Section Labels ===========
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300, fontSize: 14),
    );
  }

  // ======= Suggestion Chip ==========
  Widget _buildSuggestionChip(String label) {
    return InkWell(
      borderRadius: BorderRadius.circular(999.r),
      onTap: () {
        setState(() {
          savingNameController.text = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 6.r),
        decoration: BoxDecoration(
          color: ColorManager.backgroudNormal,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          label,
          style: getMediumStyle18(color: ColorManager.brown300, fontSize: 14),
        ),
      ),
    );
  }

  // ======== Dropdown Field ==============
  Widget _buildDropdownField(String value) {
    final List<String> items = ["Per month", "Per week"];
    return Container(
      padding: EdgeInsets.only(
        top: 14.r,
        right: 12.r,
        bottom: 14.r,
        left: 16.r,
      ),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.borderE0D9D1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: ColorManager.secondaryBackGround,
          value: _selectedFrequency,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: ColorManager.primaryButton,
            size: 20.sp,
          ),
          isExpanded: true,
          style: getRegularStyle16_400(color: ColorManager.brown400),
          items: items.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => _selectedFrequency = val);
            }
          },
        ),
      ),
    );
  }
}
