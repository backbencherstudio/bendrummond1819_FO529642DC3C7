import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.greeting, required this.userName});

  final String greeting;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customLogoText(),
            SizedBox(height: 4.h),
            Text(
              '$greeting, $userName',
              style: getRegularStyle16_400(
                fontSize: 14,
                color: ColorManager.cA87B4D,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
            Text(
              DateFormat('EEEE, MMMM d').format(now),
              style: getRegularStyle16_400(
                fontSize: 12,
                color: ColorManager.cA87B4D,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        InkWell(
          onTap: () =>
              Navigator.pushNamed(context, RoutesName.homeSettingsScreen),
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: ColorManager.secondaryBackGround,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              IconManager.userIcon,
              colorFilter: ColorFilter.mode(
                ColorManager.primaryButton,
                BlendMode.srcIn,
              ),
              width: 24.w,
              height: 24.h,
            ),
          ),
        ),
      ],
    );
  }
}
