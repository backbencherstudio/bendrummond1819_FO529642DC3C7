import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanToggleNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle(bool value) => state = value;
}

final planToggleProvider = NotifierProvider<PlanToggleNotifier, bool>(
  PlanToggleNotifier.new,
);
