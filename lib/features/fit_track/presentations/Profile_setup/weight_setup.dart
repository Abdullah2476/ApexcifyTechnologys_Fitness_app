import 'package:firebase_auth/firebase_auth.dart';

import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/Profile_setup/height_setup.dart';

import 'package:fit_track/features/fit_track/presentations/Profile_setup/widgets.dart';
import 'package:fit_track/features/fit_track/providers/userinfo_provider/user_weight_provider.dart';
import 'package:fit_track/features/fit_track/services/userServices/profile_services.dart';
import 'package:fit_track/features/shared/appbar.dart';
import 'package:fit_track/features/shared/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeightSetup extends ConsumerWidget {
  const WeightSetup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
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
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myAppbar(context),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: Center(
                    child: Container(
                      height: size.height * 0.04,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.yelow),
                      ),
                      child: Center(child: smallBOldTextYellow('Step 2/3')),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: bigTextWhite("Enter your weight (Kg)"),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: smallTextWhite(
                    'Your weight help us to calculate healthy goals',
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Center(
                  child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.transparentStroke),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.015),
                            child: Consumer(
                              builder: (context, ref, weight) {
                                final selectedWeight = ref.watch(
                                  userweightProvider,
                                );
                                return bigTextWhite(selectedWeight.toString());
                              },
                            ),
                          ),
                          smallTextWhite('Kg'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.36,
                  child: Consumer(
                    builder: (context, ref, weight) {
                      final selectedWeight = ref.watch(userweightProvider);
                      return ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (value) {
                          ref.read(userweightProvider.notifier).state =
                              value + 1;
                        },
                        itemExtent: size.height * 0.075,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 100,
                          builder: (context, index) {
                            final weight = index + 1;
                            return Text(
                              weight.toString(),
                              style: TextStyle(
                                fontSize: weight == selectedWeight ? 26 : 20,
                                fontWeight:
                                    weight == selectedWeight
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color:
                                    weight == selectedWeight
                                        ? AppColors.yelow
                                        : AppColors.white,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.09),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: Row(
                    children: [
                      Expanded(
                        child: buttonBorder('Back', () {
                          Navigator.pop(context);
                        }),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: button('Next', () async {
                          final selectedWeight = ref.watch(userweightProvider);
                          final user = FirebaseAuth.instance.currentUser?.uid;
                          await ProfileServices().addweight(
                            user!,
                            selectedWeight,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HeightSetup(),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
