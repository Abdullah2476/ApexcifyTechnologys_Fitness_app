import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/fit_track/modals/userModal.dart';

class ProfileServices {
  final firestore = FirebaseFirestore.instance;
  final firebase_auth = FirebaseAuth.instance;

  Future<void> createUser(Usermodal user) async {
    try {
      await firestore.collection('users').doc(user.userId).set({
        'name': user.name,
        'email': user.email,
        'dateOfBirth': user.dateOfBirth,
        'weight': user.weight,
        'height': user.height,
        'logSteps': user.logSteps,
      });
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<void> addName(String user, String name, String dateOfBirth) async {
    try {
      await firestore.collection('users').doc(user).update({
        'name': name,
        'dateOfBirth': dateOfBirth,
      });
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> addweight(String user, double weight) async {
    try {
      await firestore.collection('users').doc(user).update({'weight': weight});
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> addHeight(String user, int height) async {
    try {
      await firestore.collection('users').doc(user).update({'height': height});
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> addSteps(String user, int targetSteps) async {
    try {
      await firestore.collection('users').doc(user).update({
        'targetSteps': targetSteps,
      });
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> addlogSteps(String user, int logSteps) async {
    try {
      await firestore.collection('users').doc(user).update({
        'logSteps': logSteps,
      });
    } catch (e) {
      throw Exception('$e');
    }
  }
}
