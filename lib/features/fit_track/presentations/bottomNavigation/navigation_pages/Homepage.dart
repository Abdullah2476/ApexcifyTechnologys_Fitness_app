import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/log_track.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/profilePage.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/widgets.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/detailStep_items_provider.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/steps_provider.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/target_steps_provider.dart';
import 'package:fit_track/features/fit_track/services/steps/stepUpload_service.dart';

import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetSteps1 = ref
        .watch(targetSteps)
        .maybeWhen(data: (value) => value, orElse: () => null);

    ref.listen(stepCountProvider.notifier, (previous, notifier) {
      if (notifier.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sensor not found or check sensor Permission'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 5,
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          ),
        );
      }
    });
    ref.listen(stepCountProvider, (prevoius, newstepsdata) {
      if (newstepsdata != prevoius) {
        final stepupload = ref.read(stepUploadServiceProvider);
        stepupload.uploadStepsData(
          userId: FirebaseAuth.instance.currentUser!.uid,
          steps: newstepsdata,
          distance: ref.read(distanceProvider),
          calories: ref.read(caloriesProvider),
        );
      }
    });

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: SweepGradient(
            startAngle: 0,
            endAngle: 35,
            center: Alignment.topRight,
            tileMode: TileMode.decal,
            colors: [AppColors.black, AppColors.yelow],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: width * 0.08,
                      backgroundColor: Colors.transparent,
                      backgroundImage: const AssetImage('assets/logo.png'),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Badge(
                            child: Icon(
                              Icons.notifications,
                              color: AppColors.yelow,
                              size: width * 0.08,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profilepage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.person_2_outlined,
                            size: width * 0.09,
                            color: AppColors.yelow,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.05),

              Center(
                child: Consumer(
                  builder: (context, ref, progresbar) {
                    final steps = ref.watch(stepCountProvider);
                    return SleekCircularSlider(
                      initialValue: min((steps / targetSteps1) * 100, 100),
                      min: 0,
                      max: 100,
                      innerWidget: (percentage) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              smallBOldTextgrey('Steps'),
                              bigTextWhite(steps.toString()),
                              smallBOldTextgrey('/$targetSteps1'),
                              SizedBox(height: height * 0.02),
                              Container(
                                height: height * 0.06,
                                width: height * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    height * 0.03,
                                  ),
                                  border: Border.all(color: AppColors.yelow),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref
                                        .read(stepCountProvider.notifier)
                                        .resetBaseline();
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: AppColors.yelow,
                                    size: width * 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          shadowWidth: width * 0.07,
                          trackWidth: width * 0.07,
                          progressBarWidth: width * 0.07,
                        ),
                        size: width * 0.6,
                        customColors: CustomSliderColors(
                          trackColor: AppColors.white,
                          progressBarColor: AppColors.yelow,
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: height * 0.03),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: EdgeInsets.all(width * 0.06),
                crossAxisSpacing: width * 0.03,
                mainAxisSpacing: height * 0.02,
                childAspectRatio: 1.4 / 1,
                children: [
                  Consumer(
                    builder: (context, ref, calorie) {
                      final calories = ref.watch(caloriesProvider);
                      return caloriesCard(
                        'Calories',
                        calories.toString(),
                        'Kcal',
                        Icons.local_fire_department,
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, distan) {
                      final distance = ref.watch(distanceProvider);
                      return caloriesCard(
                        'Distance',
                        distance.toString(),
                        'meter',
                        Icons.directions_walk,
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, tim) {
                      final time = ref.watch(activeTimeProvider);
                      return caloriesCard(
                        'Active Time',
                        time.toString(),
                        'min',
                        Icons.access_time,
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, sped) {
                      final speed = ref.watch(speedProvider);
                      return caloriesCard(
                        'Speed',
                        speed.toString(),
                        'm/s',
                        Icons.speed,
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),
              bigTextWhite('Goals'),

              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  goalsWidget(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogTrack()),
                    ),
                    'Steps',
                    Icons.directions_run,
                  ),
                  goalsWidget(() {}, 'Calories', Icons.local_fire_department),
                  goalsWidget(() {}, 'Water', Icons.water_drop),
                  goalsWidget(() {}, 'Sleep', Icons.bed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
