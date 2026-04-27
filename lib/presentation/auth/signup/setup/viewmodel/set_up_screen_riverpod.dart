import 'package:flutter_riverpod/flutter_riverpod.dart';

// The total number of steps
const int totalSteps = 8;

// Provider to manage the current step (1 to 8)
final setupStepProvider = NotifierProvider.autoDispose<SetupStepNotifier, int>(
  SetupStepNotifier.new,
);

class SetupStepNotifier extends Notifier<int> {
  @override
  int build() => 1; // Start at step 1

  void nextStep() {
    if (state < totalSteps) {
      state++;
    }
  }

  void previousStep() {
    if (state > 1) {
      state--;
    }
  }

  void reset() => state = 1;

  double get progress => state / totalSteps;
}
