import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final stepCountProvider = StateNotifierProvider<SimpleStepNotifier, int>((ref) {
  return SimpleStepNotifier();
});

class SimpleStepNotifier extends StateNotifier<int> {
  StreamSubscription<StepCount>? _subscription;
  bool hasError = false;

  SimpleStepNotifier() : super(0) {
    _startListening();
  }

  void _startListening() {
    _subscription = Pedometer.stepCountStream.listen(
      (event) {
        hasError = false;
        state = event.steps;
      },
      onError: (error) {
        hasError = true;
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
