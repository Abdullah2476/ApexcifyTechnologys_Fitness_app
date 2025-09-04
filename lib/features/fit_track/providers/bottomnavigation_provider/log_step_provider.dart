import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final logStepCountProvider = StateNotifierProvider<SimpleLogStepNotifier, int>((
  ref,
) {
  return SimpleLogStepNotifier();
});

class SimpleLogStepNotifier extends StateNotifier<int> {
  StreamSubscription<StepCount>? _subscription;
  bool hasError = false;

  SimpleLogStepNotifier() : super(0) {
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
