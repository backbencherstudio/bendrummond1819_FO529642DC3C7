import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resource/constants/color_manger.dart';
import '../../../../../core/resource/constants/style_manager.dart';

class SetUp1Screen extends StatefulWidget {
  const SetUp1Screen({super.key});

  @override
  State<SetUp1Screen> createState() => _SetUp1ScreenState();
}

class _SetUp1ScreenState extends State<SetUp1Screen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _options = [
    {
      "title": "Same every paycheck",
      "subtitle": "Salary, hourly with set schedule",
      "icon": IconManager.tradingicon,
    },
    {
      "title": "Varies a little",
      "subtitle": "Close but not exact each time",
      "icon": IconManager.graphIcon,
    },
    {
      "title": "Varies a lot",
      "subtitle": "Gig work, tips, commissions",
      "icon": IconManager.shuffleRoundedIcon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How does your income usually come in?",
              style: getSemiBoldStyle32(color: ColorManager.textPrimary),
            ),
            SizedBox(height: 12.h),
            Text(
              "This helps set realistic expectations.",
              style: getRegularStyle16_400(color: ColorManager.brown400),
            ),
            SizedBox(height: 24.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _options.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => _buildOptionCard(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(int index) {
    final isSelected = _selectedIndex == index;
    final item = _options[index];
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.backgroundSecondary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.textPrimary
                : ColorManager.backgroundPressed100,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: ColorManager.backgroundCard,
              child: SvgPicture.asset(item['icon']),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isSelected
                      ? Text(
                          item['title'],
                          style: getRegularStyle20_600(
                            color: ColorManager.textPrimary,
                          ),
                        )
                      : Text(
                          item['title'],
                          style: getRegularStyle20_600(
                            color: ColorManager.grayBlack400,
                          ),
                        ),
                  SizedBox(height: 5.h),
                  Text(
                    item['subtitle'],
                    style: getRegularStyle14_400(
                      color: ColorManager.grayBlack400,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: ColorManager.textPrimary),
          ],
        ),
      ),
    );
  }
}
