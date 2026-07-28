import 'package:flutter/material.dart';

mixin KeyboardAwareScrollMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  final List<FocusNode> _managedFocusNodes = [];

  void registerAutoScrollFocus(
    FocusNode focusNode,
    GlobalKey targetKey, {
    double alignment = 0.2,
    Duration delay = const Duration(milliseconds: 300),
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    _managedFocusNodes.add(focusNode);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(delay, () {
          final ctx = targetKey.currentContext;
          if (ctx != null && mounted) {
            Scrollable.ensureVisible(
              ctx,
              duration: animationDuration,
              curve: Curves.easeOut,
              alignment: alignment,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
