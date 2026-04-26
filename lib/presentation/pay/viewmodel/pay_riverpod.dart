import 'package:riverpod/legacy.dart';

class PayScheduleNotifier extends StateNotifier<String> {
  PayScheduleNotifier() : super('Weekly');
  void schedule(String money) {
    state = money;
  }
}

final payScheduleProvider = StateNotifierProvider<PayScheduleNotifier, String>((
  ref,
) {
  return PayScheduleNotifier();
});
