import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/widgets/labeled_form_field.dart';
import 'package:country_picker/country_picker.dart';
import '../../../widgets/primary_button.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  String _selectedPhoneCode = '+1';

  Future<void> handForgotPassword() async {
    final rawPhone = _phoneController.text.trim();
    if (rawPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your phone number")),
      );
      return;
    }

    final phone = '$_selectedPhoneCode$rawPhone';

    final userId = await ref
        .read(forgotPasswordViewModelProvider.notifier)
        .forgotPassword(phone: phone);

    if (userId != null && mounted) {
      Navigator.pushNamed(
        context,
        RoutesName.forgotPasswordOtpRoute,
        arguments: {'phone': phone, 'userId': userId},
      );
    } else if (mounted) {
      final state = ref.read(forgotPasswordViewModelProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage ?? "Request failed")),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordViewModelProvider);

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.borderColor,
                  ),
                  SizedBox(width: 12.w),
                  customLogoText(),
                ],
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password",
                      style: getBoldStyle32(
                        color: ColorManager.brown,
                      ).copyWith(letterSpacing: -0.45),
                    ),
                    SizedBox(height: 15.h),

                    LabeledFormField(
                      label: "Phone number",
                      hintText: "(123) 456-7890",
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      prefix: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            showDragHandle: false,
                            countryListTheme: CountryListThemeData(
                              bottomSheetHeight:
                                  MediaQuery.of(context).size.height * 0.66,
                              textStyle: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                              ),
                              searchTextStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 0.h,
                              ),
                            ),
                            onSelect: (Country country) {
                              setState(() {
                                _selectedPhoneCode = '+${country.phoneCode}';
                              });
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: ColorManager.greyColor.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _selectedPhoneCode,
                                style: getRegularStyle14_400(
                                  color: ColorManager.blackColor,
                                ).copyWith(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),

              PrimaryButton(
                title: "Send",
                isLoading: state.isLoading,
                onTap: () => handForgotPassword(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
