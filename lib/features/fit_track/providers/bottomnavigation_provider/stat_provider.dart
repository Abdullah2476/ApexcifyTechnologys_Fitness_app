import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final stepDataProvider = StreamProvider<List<BarChartGroupData>>((ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('users')
      .doc(userId)
      .collection('stepData')
      .orderBy('timestamp', descending: false)
      .snapshots()
      .map((snapshot) {
        final docs = snapshot.docs;
        // Map Firestore docs to BarChartGroupData by date index
        return List<BarChartGroupData>.generate(docs.length, (index) {
          final data = docs[index].data();
          final steps = (data['steps'] ?? 0).toDouble();

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: steps,
                color: AppColors.yelow,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        });
      });
});
