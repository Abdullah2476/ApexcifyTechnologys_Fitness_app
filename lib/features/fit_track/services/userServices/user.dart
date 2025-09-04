import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/fit_track/modals/userModal.dart';

class Userrepo {
  final firestore = FirebaseFirestore.instance;
  final firebase_auth = FirebaseAuth.instance;
  Future<Usermodal?> fetchProfileData() async {
    final uid = firebase_auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;

    return Usermodal.fromMap(doc.data()!);
  }

  Stream<Usermodal?> streamCurrentUser() {
    final uid = firebase_auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return Usermodal.fromMap(doc.data()!);
    });
  }
}
