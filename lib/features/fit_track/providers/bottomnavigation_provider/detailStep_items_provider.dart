import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/steps_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//proivder to caluclute distance
final distanceProvider = StateProvider<double>((ref) {
  final steps = ref.watch(stepCountProvider);
  const strideLengthMeters = 0.7;
  return steps * strideLengthMeters;
});
//to calculate calories
final caloriesProvider = StateProvider<double>((ref) {
  final steps = ref.watch(stepCountProvider);
  const caloriesPerStep = 0.05;
  return steps * caloriesPerStep;
});
//to calculate time
final activeTimeProvider = StateProvider<double>((ref) {
  final steps = ref.watch(stepCountProvider);
  const stepsPerMinute = 100;
  if (steps == 0) return 0;
  return steps / stepsPerMinute;
});
//to calculate speed
final speedProvider = Provider<double>((ref) {
  final steps = ref.watch(stepCountProvider);
  const strideLengthMeters = 0.7;
  const stepsPerMinute = 100;

  final distance = steps * strideLengthMeters;
  final timeSeconds = (steps / stepsPerMinute) * 60;

  if (timeSeconds == 0) return 0;
  return distance / timeSeconds;
});
