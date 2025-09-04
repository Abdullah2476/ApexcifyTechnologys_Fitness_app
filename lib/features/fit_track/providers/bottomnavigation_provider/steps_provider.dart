import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final stepCountProvider = StateNotifierProvider<SimpleStepNotifier, int>((ref) {
  return SimpleStepNotifier();
});

class SimpleStepNotifier extends StateNotifier<int> {
  StreamSubscription<StepCount>? _subscription;
  bool hasError = false;

  int _baseline = 0;

  SimpleStepNotifier() : super(0) {
    _startListening();
  }

  void _startListening() {
    _subscription = Pedometer.stepCountStream.listen(
      (event) {
        hasError = false;

        if (_baseline == 0) {
          _baseline = event.steps;
        }

        state = event.steps - _baseline;
      },
      onError: (error) {
        hasError = true;
      },
    );
  }

  /// Reset baseline when a new user logs in
  void resetBaseline() {
    _baseline = 0;
    state = 0;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
