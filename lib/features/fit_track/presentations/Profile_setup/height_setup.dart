import 'package:firebase_auth/firebase_auth.dart';

import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/NavigationBar.dart';
import 'package:fit_track/features/fit_track/presentations/Profile_setup/widgets.dart';
import 'package:fit_track/features/fit_track/providers/userinfo_provider/height_provider.dart';
import 'package:fit_track/features/fit_track/services/userServices/profile_services.dart';
import 'package:fit_track/features/shared/appbar.dart';
import 'package:fit_track/features/shared/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeightSetup extends ConsumerWidget {
  const HeightSetup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myAppbar(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: size.height * 0.04, // instead of 30
                      width: size.width * 0.2, // instead of 80
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.yelow),
                      ),
                      child: Center(child: smallBOldTextYellow('Step 3/3')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bigTextWhite("Enter your Height (cm)"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: smallTextWhite(
                    'Your height help us to calculate healthy goals',
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
                            padding: const EdgeInsets.all(5.0),
                            child: Consumer(
                              builder: (context, ref, height) {
                                final selectedHeight = ref.watch(
                                  userHeightProvider,
                                );
                                return bigTextWhite(selectedHeight.toString());
                              },
                            ),
                          ),
                          smallTextWhite('cm'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.36,
                  child: Consumer(
                    builder: (context, ref, height) {
                      final selectedWeight = ref.watch(userHeightProvider);
                      return ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (value) {
                          ref.read(userHeightProvider.notifier).state =
                              value + 1;
                        },
                        itemExtent: 60,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 100,
                          builder: (context, index) {
                            final height = index + 1;
                            return Text(
                              height.toString(),
                              style: TextStyle(
                                fontSize: height == selectedWeight ? 26 : 20,
                                fontWeight:
                                    height == selectedWeight
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color:
                                    height == selectedWeight
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buttonBorder('Back', () {
                          Navigator.pop(context);
                        }),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: button('Next', () async {
                          final selectedHeight = ref.watch(userHeightProvider);
                          final user = FirebaseAuth.instance.currentUser?.uid;
                          await ProfileServices().addHeight(
                            user!,
                            selectedHeight,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyNavigationBar();
                              },
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
