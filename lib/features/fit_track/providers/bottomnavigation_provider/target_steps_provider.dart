import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final targetSteps = FutureProvider((ref) async {
  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final doc = await firestore.collection('users').doc(user?.uid).get();
  if (doc.exists) {
    final data = doc.data();
    return data!['targetSteps'] ?? 0;
  }
});
