import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin SocialLoginMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  Future<bool> googleSignIn();

  Future<bool> appleSignIn();

  bool get isGoogleLoading;

  bool get isAppleLoading;

  String? get errorMessage;

  void onSocialLoginSuccess();

  Future<void> handleGoogleLogin() async {
    if (isGoogleLoading) return;
    final success = await googleSignIn();
    if (!mounted) return;
    if (success) {
      onSocialLoginSuccess();
    } else {
      _showError('Google sign in failed');
    }
  }

  Future<void> handleAppleLogin() async {
    if (isAppleLoading) return;
    final success = await appleSignIn();
    if (!mounted) return;
    if (success) {
      onSocialLoginSuccess();
    } else {
      _showError('Apple sign in failed');
    }
  }

  void _showError(String fallback) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(fallback)));
  }
}
