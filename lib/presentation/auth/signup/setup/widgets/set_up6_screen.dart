import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/icon_manager.dart';
import '../../../../../core/resource/constants/style_manager.dart';
import '../../../../../core/resource/utils.dart';
import '../../../../../data/sources/local/shared_preference/shared_preference.dart';
import '../../../../widgets/custom_from_field.dart';
import '../../../../widgets/outline_button.dart';
import '../../../../widgets/primary_button.dart';
import '../viewmodel/set_up_screen_riverpod.dart';
import '../viewmodel/setup_data_provider.dart';
import 'custom_dash_border.dart';

class SetUp6Screen extends ConsumerStatefulWidget {
  final bool isStandalone;
  final VoidCallback? onContinue;
  final VoidCallback? onSkip;

  const SetUp6Screen({
    super.key,
    this.isStandalone = false,
    this.onContinue,
    this.onSkip,
  });

  @override
  ConsumerState<SetUp6Screen> createState() => _SetUp6ScreenState();
}

class _SetUp6ScreenState extends ConsumerState<SetUp6Screen> {
  bool isAdding = false;
  int? editingIndex;
  bool isChecked = false;
  bool isSubmitting = false;

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final dayController = TextEditingController();
  final startDateController = TextEditingController();

  DateTime? _selectedStartDate;
  List<DateTime> _subsequentPayments = [];

  String? nameError;
  String? amountError;
  String? dayError;
  String? startDateError;

  @override
  void initState() {
    super.initState();
    _loadPersistedBills();
  }

  Future<void> _loadPersistedBills() async {
    final currentBills = ref.read(setupDataProvider).bills;
    if (currentBills.isEmpty) {
      final saved = await SharedPreferenceData.getBills();
      if (saved.isNotEmpty && mounted) {
        ref.read(setupDataProvider.notifier).setBills(saved);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    dayController.dispose();
    startDateController.dispose();
    super.dispose();
  }

  void _onStartDateSelected(DateTime date) {
    setState(() {
      _selectedStartDate = date;
      startDateController.text = DateFormat('MMM d, yyyy').format(date);
      startDateError = null;
      _subsequentPayments = List.generate(
        3,
        (index) => date.add(Duration(days: 14 * (index + 1))),
      );
    });
  }

  Future<void> _pickStartingDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.brown,
              onPrimary: Colors.white,
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: ColorManager.brown,
              headerForegroundColor: ColorManager.whiteColor,
              backgroundColor: ColorManager.backgroundSecondary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _onStartDateSelected(picked);
    }
  }

  DateTime? _parseDate(String text) {
    if (text.isEmpty) return null;
    final iso = DateTime.tryParse(text);
    if (iso != null) return iso;
    try {
      return DateFormat('MMM d, yyyy').parse(text);
    } catch (_) {}
    try {
      return DateFormat('MMMM dd, yyyy').parse(text);
    } catch (_) {}
    try {
      return DateFormat('yyyy-MM-dd').parse(text);
    } catch (_) {}
    return null;
  }

  bool _validateForm() {
    bool isValid = true;
    String? firstError;

    final name = nameController.text.trim();
    if (name.isEmpty) {
      nameError = "Please enter a bill name";
      firstError ??= nameError;
      isValid = false;
    } else {
      nameError = null;
    }

    final amountText = amountController.text.trim().replaceAll('\$', '');
    final amount = double.tryParse(amountText);
    if (amountText.isEmpty) {
      amountError = "Please enter an amount";
      firstError ??= amountError;
      isValid = false;
    } else if (amount == null || amount <= 0) {
      amountError = "Amount must be a positive number";
      firstError ??= amountError;
      isValid = false;
    } else {
      amountError = null;
    }

    if (!isChecked) {
      final dayText = dayController.text.trim();
      final day = int.tryParse(dayText);
      if (dayText.isEmpty) {
        dayError = "Enter due day";
        firstError ??= dayError;
        isValid = false;
      } else if (day == null || day < 1 || day > 31) {
        dayError = "Due day must be between 1 and 31";
        firstError ??= dayError;
        isValid = false;
      } else {
        dayError = null;
      }
    } else {
      if (_selectedStartDate == null &&
          startDateController.text.trim().isEmpty) {
        startDateError = "Select starting date";
        firstError ??= startDateError;
        isValid = false;
      } else {
        startDateError = null;
      }
    }

    setState(() {});

    if (!isValid && firstError != null) {
      Utils.showToast(
        message: firstError,
        backgroundColor: ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
    }

    return isValid;
  }

  Future<void> _saveBill() async {
    if (isSubmitting) return;

    if (!_validateForm()) return;

    final name = nameController.text.trim();
    final cleanAmountText = amountController.text.trim().replaceAll('\$', '');
    final amountVal = double.parse(cleanAmountText);
    final amountFormatted = amountVal % 1 == 0
        ? amountVal.toInt().toString()
        : amountVal.toStringAsFixed(2);

    final bills = List<Map<String, String>>.from(
      ref.read(setupDataProvider).bills,
    );

    final duplicateIndex = bills.indexWhere(
      (b) => (b['name'] ?? '').trim().toLowerCase() == name.toLowerCase(),
    );
    if (duplicateIndex != -1 && duplicateIndex != editingIndex) {
      Utils.showToast(
        message: "A bill named '$name' already exists",
        backgroundColor: ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final billMap = <String, String>{
        'name': name,
        'amount': amountFormatted,
        'day': isChecked ? '' : dayController.text.trim(),
        'frequency': isChecked ? 'EVERY_2_WEEKS' : 'MONTHLY',
        'isBiWeekly': isChecked ? 'true' : 'false',
        'startDate': isChecked
            ? (_selectedStartDate != null
                  ? DateFormat('MMM d, yyyy').format(_selectedStartDate!)
                  : startDateController.text.trim())
            : '',
        'subsequentPayments': isChecked
            ? _subsequentPayments
                  .map((d) => DateFormat('MMM d, yyyy').format(d))
                  .join(', ')
            : '',
      };

      if (editingIndex != null &&
          editingIndex! >= 0 &&
          editingIndex! < bills.length) {
        bills[editingIndex!] = billMap;
      } else {
        bills.add(billMap);
      }

      ref.read(setupDataProvider.notifier).setBills(bills);
      await SharedPreferenceData.saveBills(bills);

      Utils.showToast(
        message: editingIndex != null
            ? "Bill updated successfully"
            : "Bill added successfully",
        backgroundColor: ColorManager.textPrimary,
        textColor: ColorManager.whiteColor,
      );

      _resetForm();
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  Future<void> _removeBill(int index) async {
    if (isSubmitting) return;

    final bills = List<Map<String, String>>.from(
      ref.read(setupDataProvider).bills,
    );

    if (index >= 0 && index < bills.length) {
      final removed = bills.removeAt(index);
      ref.read(setupDataProvider.notifier).setBills(bills);
      await SharedPreferenceData.saveBills(bills);

      if (editingIndex == index) {
        _resetForm();
      } else if (editingIndex != null && editingIndex! > index) {
        editingIndex = editingIndex! - 1;
      }

      Utils.showToast(
        message: "${removed['name'] ?? 'Bill'} removed",
        backgroundColor: ColorManager.textPrimary,
        textColor: ColorManager.whiteColor,
      );
      setState(() {});
    }
  }

  void _startEditing(int index, Map<String, String> bill) {
    setState(() {
      editingIndex = index;
      isAdding = true;
      nameController.text = bill['name'] ?? '';
      amountController.text = bill['amount'] ?? '';
      isChecked =
          bill['isBiWeekly'] == 'true' || bill['frequency'] == 'EVERY_2_WEEKS';

      nameError = null;
      amountError = null;
      dayError = null;
      startDateError = null;

      if (isChecked) {
        dayController.clear();
        final dateStr = bill['startDate'] ?? '';
        startDateController.text = dateStr;
        final parsed = _parseDate(dateStr);
        if (parsed != null) {
          _selectedStartDate = parsed;
          _subsequentPayments = List.generate(
            3,
            (i) => parsed.add(Duration(days: 14 * (i + 1))),
          );
        } else {
          _selectedStartDate = null;
          _subsequentPayments = [];
        }
      } else {
        dayController.text = bill['day'] ?? '';
        startDateController.clear();
        _selectedStartDate = null;
        _subsequentPayments = [];
      }
    });
  }

  void _resetForm() {
    nameController.clear();
    amountController.clear();
    dayController.clear();
    startDateController.clear();
    setState(() {
      isChecked = false;
      _selectedStartDate = null;
      _subsequentPayments = [];
      editingIndex = null;
      isAdding = false;
      nameError = null;
      amountError = null;
      dayError = null;
      startDateError = null;
    });
  }

  Future<void> _handleContinue() async {
    if (isSubmitting) return;
    setState(() => isSubmitting = true);
    try {
      final bills = ref.read(setupDataProvider).bills;
      await SharedPreferenceData.saveBills(bills);
      if (widget.onContinue != null) {
        widget.onContinue!();
      } else {
        ref.read(setupStepProvider.notifier).nextStep();
      }
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  Future<void> _handleNoBills() async {
    if (isSubmitting) return;
    setState(() => isSubmitting = true);
    try {
      ref.read(setupDataProvider.notifier).setBills([]);
      await SharedPreferenceData.saveBills([]);
      if (widget.onSkip != null) {
        widget.onSkip!();
      } else {
        ref.read(setupStepProvider.notifier).nextStep();
      }
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bills = ref.watch(setupDataProvider.select((s) => s.bills));

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Any other regular bills?",
                style: getSemiBoldStyle32(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 15.h),
              Text(
                "Subscriptions, insurance, utilities — anything monthly.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),

              if (bills.isEmpty && !isAdding) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Center(
                    child: Text(
                      "No bills added yet.",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                  ),
                ),
              ],

              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: bills.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return savedBillCard(bills[index], index);
                },
              ),

              isAdding ? _buildInputForm() : _buildAddBillButton(),

              if (widget.isStandalone) ...[
                SizedBox(height: 24.h),
                PrimaryButton(title: "Continue", onTap: _handleContinue),
                SizedBox(height: 12.h),
                CustomOutlinedButton(
                  title: "No regular bills",
                  onTap: _handleNoBills,
                ),
                SizedBox(height: 24.h),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// ************* Saved bill card widget **************
  Widget savedBillCard(Map<String, String> bill, int index) {
    final isBiWeekly =
        bill['isBiWeekly'] == 'true' || bill['frequency'] == 'EVERY_2_WEEKS';
    final subtitle = isBiWeekly
        ? (bill['startDate'] != null && bill['startDate']!.isNotEmpty
              ? "Every 2 weeks • From ${bill['startDate']}"
              : "Every 2 weeks")
        : (bill['day'] != null && bill['day']!.isNotEmpty
              ? "Monthly • Due day ${bill['day']}"
              : "Monthly");

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: editingIndex == index
              ? ColorManager.brown
              : ColorManager.brown200,
          width: 1.5.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill['name'] ?? 'N/A',
                  style: getRegularStyle18_400(color: ColorManager.brown400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: getRegularStyle14_400(
                    color: ColorManager.grayBlack400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "\$${bill['amount'] ?? '0'}",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                key: Key('edit_bill_$index'),
                onTap: () => _startEditing(index, bill),
                child: Icon(
                  Icons.edit_outlined,
                  size: 20.sp,
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                key: Key('delete_bill_$index'),
                onTap: () => _removeBill(index),
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: editingIndex != null
              ? ColorManager.brown
              : ColorManager.borderColor1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bill Name",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          CustomFromField(
            hintText: "e.g. Netflix, Gym, Electric",
            controller: nameController,
            keyboardType: TextInputType.text,
            errorText: nameError,
            onChanged: (_) {
              if (nameError != null) setState(() => nameError = null);
            },
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill Amount",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomFromField(
                      hintText: "0.00",
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixIcon: SvgPicture.asset(IconManager.dollar),
                      errorText: amountError,
                      onChanged: (_) {
                        if (amountError != null) {
                          setState(() => amountError = null);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isChecked ? "Starting due date" : "Due day",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    if (isChecked)
                      GestureDetector(
                        onTap: () => _pickStartingDate(context),
                        behavior: HitTestBehavior.opaque,
                        child: IgnorePointer(
                          child: CustomFromField(
                            hintText: "Select date",
                            controller: startDateController,
                            readOnly: true,
                            errorText: startDateError,
                            suffixIcon: SvgPicture.asset(IconManager.calendar),
                          ),
                        ),
                      )
                    else
                      CustomFromField(
                        hintText: "1 - 31",
                        controller: dayController,
                        keyboardType: TextInputType.number,
                        errorText: dayError,
                        onChanged: (_) {
                          if (dayError != null) {
                            setState(() => dayError = null);
                          }
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              setState(() {
                isChecked = !isChecked;
                dayError = null;
                startDateError = null;
                if (isChecked && _selectedStartDate != null) {
                  _onStartDateSelected(_selectedStartDate!);
                }
              });
            },
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: ColorManager.brown400.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: isChecked
                      ? Icon(
                          Icons.check,
                          size: 14.sp,
                          color: ColorManager.textPrimary,
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Every 2 weeks Payment",
                    style: getRegularStyle16_400(
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isChecked && _subsequentPayments.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorManager.backgroundSecondary,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.borderColor1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next payments at 14-day intervals:",
                    style: getRegularStyle14_400(color: ColorManager.brown400),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    _subsequentPayments
                        .map((d) => DateFormat('MMM d, yyyy').format(d))
                        .join('  •  '),
                    style: getLightStyle14_500(color: ColorManager.textPrimary),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(onTap: _resetForm, title: "Cancel"),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: isSubmitting
                    ? Center(
                        child: SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      )
                    : PrimaryButton(
                        onTap: _saveBill,
                        title: editingIndex == null ? "Add" : "Update",
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddBillButton() {
    return CustomPaint(
      painter: DashedRectPainter(color: ColorManager.brown400),
      child: InkWell(
        onTap: () {
          setState(() {
            isAdding = true;
            editingIndex = null;
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundColor: ColorManager.backgroundCard,
                child: Icon(Icons.add, color: ColorManager.brown, size: 20.sp),
              ),
              SizedBox(width: 15.w),
              Text(
                "Add a bill",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
