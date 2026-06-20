import 'dart:convert';
import 'dart:io';

import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/user_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  bool _initialized = false;
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 70,
    );
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUser();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String _getInitial(String? name) {
    if (name != null && name.isNotEmpty) return name[0].toUpperCase();
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).user;
    if (user != null && !_initialized) {
      _initialized = true;
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phoneNumber ?? '';
      _dobController.text = user.dateOfBirth ?? '';
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====== Back Button & Title ===========
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.backgroundPressed100,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Account',
                    style: getSemiBoldStyle22(
                      color: ColorManager.brown,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Profile Image with Edit Icon
              Center(
                child: Stack(
                  children: [
                    _pickedImage != null
                        ? Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorManager.whiteColor,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: FileImage(_pickedImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : user?.avatar != null
                        ? Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorManager.whiteColor,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(user!.avatar!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorManager.brown,
                            ),
                            child: Center(
                              child: Text(
                                _getInitial(user?.name),
                                style: getBoldStyle32(
                                  color: ColorManager.whiteColor,
                                ).copyWith(fontSize: 28.sp),
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: ColorManager.brown,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorManager.grayBlack400,
                              width: 2,
                            ),
                          ),
                          child: SvgPicture.asset(IconManager.editIcon),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // =========== Form Fields ============
              _buildLabel("Your full name"),
              SizedBox(height: 6.h),
              CustomFromField(controller: _nameController),
              SizedBox(height: 12.h),

              _buildLabel("Email address"),
              SizedBox(height: 6.h),
              CustomFromField(controller: _emailController),
              SizedBox(height: 12.h),

              _buildLabel("Password"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: 'Your Password',
                isSecured: true,
              ),

              SizedBox(height: 12.h),
              _buildLabel("Confirm Password"),
              SizedBox(height: 6.h),
              CustomFromField(
                hintText: 'Confirm your password',
                isSecured: true,
              ),

              SizedBox(height: 12.h),
              _buildLabel("Phone number"),
              SizedBox(height: 6.h),
              CustomFromField(controller: _phoneController),
              SizedBox(height: 12.h),
              _buildLabel("Date of birth"),
              SizedBox(height: 8.h),
              CustomFromField(controller: _dobController),
              SizedBox(height: 32.h),
              // ========== Action Buttons ============
              Row(
                children: [
                  Expanded(
                    child: _buildButton("Cancel", () => Navigator.pop(context), isSecondary: true),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _buildButton("Save", () async {
                      String? avatarBase64;
                      if (_pickedImage != null) {
                        final bytes = await _pickedImage!.readAsBytes();
                        avatarBase64 = base64Encode(bytes);
                      }
                      final errorMessage = await ref
                          .read(userProvider.notifier)
                          .updateProfile(
                            name: _nameController.text,
                            phoneNumber: _phoneController.text,
                            dateOfBirth: _dobController.text,
                            avatar: avatarBase64,
                          );
                      if (context.mounted) {
                        setState(() => _pickedImage = null);
                        final isSuccess = errorMessage == null;
                        Utils.showToast(
                          message: isSuccess
                              ? "Profile updated"
                              : errorMessage,
                          backgroundColor: isSuccess
                              ? ColorManager.successColor
                              : ColorManager.errorColor,
                          textColor: ColorManager.whiteColor,
                        );
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: Section Labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getRegularStyle16_400(color: ColorManager.brown300, fontSize: 14),
    );
  }

  // ================= Bottom Buttons ==================
  Widget _buildButton(
    String label,
    VoidCallback onTap, {
    bool isSecondary = false,
  }) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary
              ? Colors.transparent
              : ColorManager.brown,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: isSecondary
                ? BorderSide(color: ColorManager.backgroundPressed100)
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: getMediumStyle18(
            color: isSecondary ? ColorManager.brown : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
