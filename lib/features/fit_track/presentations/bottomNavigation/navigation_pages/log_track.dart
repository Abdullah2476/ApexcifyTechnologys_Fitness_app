import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/log_step_provider.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LogTrack extends ConsumerWidget {
  const LogTrack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser?.uid;
    final stream =
        FirebaseFirestore.instance.collection('users').doc(user).snapshots();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: SweepGradient(
            startAngle: 0,
            endAngle: 35,
            center: Alignment.topRight,
            tileMode: TileMode.decal,

            colors: [AppColors.black, AppColors.yelow],
          ),
        ),
        child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            final doc = snapshot.data?.data();
            final int logStep = doc?['logSteps'] ?? 0;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: AppColors.white),
                      ),
                      bigTextWhite('Steps'),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: bigTextWhite('Live Goal Tracking'),
                      ),
                      Center(
                        child: Consumer(
                          builder: (context, ref, progresbar) {
                            final step = ref.watch(logStepCountProvider);
                            return SleekCircularSlider(
                              initialValue: min(((step / logStep) * 100), 100),
                              min: 0,
                              max: 100,
                              innerWidget: (percentage) {
                                return Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 80),
                                      smallBOldTextgrey('Steps'),
                                      bigTextWhite(step.toString()),
                                      smallBOldTextgrey(
                                        '/${logStep.toString()}',
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          border: Border.all(
                                            color: AppColors.yelow,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.pause,
                                            color: AppColors.yelow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              appearance: CircularSliderAppearance(
                                customWidths: CustomSliderWidths(
                                  shadowWidth: 30,
                                  trackWidth: 30,
                                  progressBarWidth: 30,
                                ),
                                size: 250,
                                customColors: CustomSliderColors(
                                  trackColor: AppColors.white,
                                  progressBarColor: AppColors.yelow,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
