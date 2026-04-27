import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/image_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Header Image with Gradient Fade
            SizedBox(
              height: 330.882.h,
              width: double.infinity,
              child: Image.asset(ImageManager.teaCup, fit: BoxFit.cover),
            ),
            // Stack(
            //   children: [
            //     Container(
            //       height: 300,
            //       width: double.infinity,
            //       decoration: const BoxDecoration(
            //         gradient: LinearGradient(
            //           begin: Alignment.topCenter,
            //           end: Alignment.bottomCenter,
            //           colors: [Color(0xFF9E774B), Color(0xFF63422B)],
            //         ),
            //       ),
            //       child: Center(
            //         child: Padding(
            //           padding: EdgeInsets.only(bottom: 40.0.h),
            //           child: Image.asset(ImageManager.teaCup),

            //           // child: Image.network(
            //           //   'https://cdn-icons-png.flaticon.com/512/924/924514.png',
            //           //   height: 180,
            //           //   color: bgColor.withOpacity(0.9),
            //           //   colorBlendMode: BlendMode.modulate,
            //           // ),
            //         ),
            //       ),
            //     ),
            //     // The fade effect at the bottom of the image
            //     Positioned(
            //       bottom: 0,
            //       left: 0,
            //       right: 0,
            //       child: Container(
            //         height: 100,
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [bgColor.withOpacity(0), bgColor],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            //  Main Content
            Transform.translate(
              offset: Offset(0, -45.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Personalized",
                      style: getLightStyle14_400(
                        color: ColorManager.goldAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Stability profile.",
                      style: getBoldStyle24(
                        color: ColorManager.brown400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "\$185",
                      style: getRegularStyle16_600(
                        color: ColorManager.accentBrown,
                        fontSize: 56.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "safe to spend every week",
                      style: getLightStyle14_400(color: ColorManager.brown300),
                    ),
                    SizedBox(height: 16.h),
              
                    // ========== Status Pill ===========
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFFBF8F2),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: ColorManager.brown400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "You have breathing room",
                            style: getLightStyle14_400(
                              color: ColorManager.brown400,
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    SizedBox(height: 16.h),
                    Text(
                      "Close is perfect. We'll adjust later.",
                      style: getRegularStyle16_400(color: ColorManager.brown400),
                    ),
                    SizedBox(height: 24.h),
              
                    // ======= Calculation Card ===========
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(16.r),
              
                        border: Border.all(
                          color: Color(0xFFE0D9D1),
                          width: 1.w,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildCardRow1("Take-home pay", "+\$1400"),
                          Divider(thickness: 1, color: ColorManager.borderColor2),
                          _buildCardRow2("Rent / mortgage", "-\$500"),
                          SizedBox(height: 12),
                          _buildCardRow2("Car payment", "-\$500"),
                          SizedBox(height: 12),
                          _buildCardRow2("Bills (2)", "-\$125"),
                          SizedBox(height: 12),
                          _buildCardRow2("Savings goals (2)", "-\$90"),
                          Divider(thickness: 1, color: ColorManager.borderColor2),
                          _buildCardRow1("Safe to spend", "\$185"),
                        ],
                      ),
                    ),
              
                    SizedBox(height: 24.h),
              
                    // 4. Description Text
                    Text(
                      "Every bill, debt payment, and savings goal you entered is already subtracted. What's left is yours to spend — without worrying whether you've covered the essentials.",
                      style: getRegularStyle16_400(color: ColorManager.brown400),
                    ),
              
                    SizedBox(height: 32.h),
              
                    // 5. Action Buttons
                    PrimaryButton(
                      title: 'Start tracking',
                      onTap: () {
                        print('click');
                      },
                    ),
                    SizedBox(height: 12.h),
                    PrimaryButton(
                      title: 'Adjust something',
                      onTap: () {},
                      textStyle: getMediumStyle18(
                        color: ColorManager.black400,
                        fontWeight: FontWeight.w500,
                      ),
                      isActive: true,
                      border: Border.all(
                        color: Color(0xFFDFE1E7),
                        width: 1.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardRow1(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getRegularStyle16_500(color: ColorManager.textPrimary),
        ),
        Text(
          value,
          style: getRegularStyle16_500(color: ColorManager.textPrimary),
        ),
      ],
    );
  }

  Widget _buildCardRow2(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: getRegularStyle16_400(color: ColorManager.brown400)),
        Text(value, style: getRegularStyle16_400(color: ColorManager.brown400)),
      ],
    );
  }
}
