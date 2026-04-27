import 'package:flutter_riverpod/legacy.dart';

class PlanToggleNotifier extends StateNotifier<bool> {
  PlanToggleNotifier() : super(true);
  void toggle(bool value) {
    state = value;
  }
}

final planToggleProvider = StateNotifierProvider<PlanToggleNotifier, bool>((
  ref,
) {
  return PlanToggleNotifier();
});
