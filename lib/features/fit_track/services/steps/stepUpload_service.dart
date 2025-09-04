import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepUploadService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> uploadStepsData({
    required String userId,
    required int steps,
    required double distance,
    required double calories,
  }) async {
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('stepData')
        .doc(DateTime.now().toIso8601String().substring(0, 10));

    await docRef.set({
      'steps': steps,
      'distance': distance,
      'calories': calories,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

final stepUploadServiceProvider = StateProvider<StepUploadService>((ref) {
  return StepUploadService();
});
