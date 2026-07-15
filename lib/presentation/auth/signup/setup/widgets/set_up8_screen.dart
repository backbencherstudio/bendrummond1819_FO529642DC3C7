import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/widgets/custom_dash_border.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/icon_manager.dart';
import '../../../../../core/resource/constants/style_manager.dart';
import '../../../../widgets/custom_from_field.dart';
import '../../../../widgets/outline_button.dart';
import '../../../../widgets/primary_button.dart';

class SetUp8Screen extends ConsumerStatefulWidget {
  const SetUp8Screen({super.key});

  @override
  ConsumerState<SetUp8Screen> createState() => _SetUp8ScreenState();
}

class _SetUp8ScreenState extends ConsumerState<SetUp8Screen> {
  bool isAdding = false;

  final savingNameController = TextEditingController();
  final amountController = TextEditingController();
  final frequencyController = TextEditingController();

  String? _selectedFrequency;

  static const List<Map<String, String>> _frequencyOptions = [
    {'label': 'Weekly', 'value': 'WEEKLY'},
    {'label': 'Every 2 weeks', 'value': 'EVERY_2_WEEKS'},
    {'label': 'Twice a month', 'value': 'TWICE_A_MONTH'},
    {'label': 'Monthly', 'value': 'MONTHLY'},
  ];

  void _showFrequencyPicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _frequencyOptions.map((opt) {
            return ListTile(
              title: Text(opt['label']!),
              trailing: _selectedFrequency == opt['value']
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                setState(() {
                  _selectedFrequency = opt['value'];
                  frequencyController.text = opt['label']!;
                });
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    savingNameController.dispose();
    amountController.dispose();
    frequencyController.dispose();
    super.dispose();
  }

  void _addNewGoal() {
    final name = savingNameController.text.trim();
    final amount = amountController.text.trim();
    if (name.isEmpty || amount.isEmpty) return;

    final frequency = _selectedFrequency ?? 'MONTHLY';

    final savings = List<Map<String, String>>.from(
      ref.read(setupDataProvider).savings,
    );
    savings.add({
      'savingName': name,
      'amount': amount,
      'frequency': frequency,
    });
    ref.read(setupDataProvider.notifier).setSavings(savings);
    setState(() {
      isAdding = false;
      savingNameController.clear();
      amountController.clear();
      frequencyController.clear();
      _selectedFrequency = null;
    });
  }

  void _removeGoal(Map<String, String> goal) {
    final savings = List<Map<String, String>>.from(
      ref.read(setupDataProvider).savings,
    );
    savings.remove(goal);
    ref.read(setupDataProvider.notifier).setSavings(savings);
  }

  @override
  Widget build(BuildContext context) {
    final savings = ref.watch(setupDataProvider.select((s) => s.savings));

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Saving for anything?",
                style: getSemiBoldStyle32(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 15.h),
              Text(
                "Start small — even a little helps. You can add more later.",
                style: getRegularStyle16_400(color: ColorManager.brown400),
              ),
              SizedBox(height: 24.h),

              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: savings.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return savingCard(savings[index]);
                },
              ),

              isAdding ? _buildInputForm() : _buildAddBillButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// ************* Saved bill card widget **************
  Widget savingCard(Map<String, String> save) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.brown200, width: 1.5.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                save['savingName'] ?? "N/A",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              Text(
                _frequencyLabel(save['frequency'] ?? ''),
                style: getRegularStyle14_400(color: ColorManager.grayBlack400),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "\$${save['amount'] ?? '0'}",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => _removeGoal(save),
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

  String _frequencyLabel(String value) {
    for (final opt in _frequencyOptions) {
      if (opt['value'] == value) return opt['label']!;
    }
    return 'Monthly';
  }

  Widget _buildInputForm() {
    final List<String> suggestions = [
      "Emergency fund",
      "Vacation",
      "New car",
      "Down payment",
      "Holiday gifts",
    ];
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.borderColor1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What are you saving for?",
            style: getRegularStyle14_400(color: ColorManager.brown400),
          ),
          SizedBox(height: 6.h),
          CustomFromField(
            hintText: "Buy a Iphone 17 Pro",
            controller: savingNameController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: suggestions.map((suggestion) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    savingNameController.text = suggestion;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.backgroudNormal,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    suggestion,
                    style: getRegularStyle14_400(color: ColorManager.brown300),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomFromField(
                      hintText: "100",
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: SvgPicture.asset(IconManager.dollar),
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
                      "Frequency",
                      style: getRegularStyle14_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: _showFrequencyPicker,
                      child: Container(
                        height: 52.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.backgroundSecondary,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: ColorManager.borderColor1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                frequencyController.text.isEmpty
                                    ? "Select frequency"
                                    : frequencyController.text,
                                style: getRegularStyle16_400(
                                  color: frequencyController.text.isEmpty
                                      ? ColorManager.brown300
                                      : ColorManager.brown400,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: ColorManager.brown400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onTap: () => setState(() => isAdding = false),
                  title: "Cancel",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: PrimaryButton(onTap: _addNewGoal, title: "Add"),
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
        onTap: () => setState(() => isAdding = true),
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
                "Add a goal",
                style: getRegularStyle18_400(color: ColorManager.brown400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
