import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/core/utiles/validators.dart';
import 'package:fit_track/features/fit_track/presentations/Profile_setup/widgets.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/NavigationBar.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/add_log_provider.dart';
import 'package:fit_track/features/fit_track/services/userServices/profile_services.dart';
import 'package:fit_track/features/shared/buttons.dart';
import 'package:fit_track/features/shared/mytextfield.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddLog extends StatelessWidget {
  final String title;
  final IconData? icons;
  final String? image;
  AddLog({super.key, required this.title, this.icons, this.image});
  final countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: AppColors.white),
                    ),
                    bigTextWhite(title),
                  ],
                ),
                bigTextWhite('Set Daily $title Goal'),
                smallBOldTextgrey(
                  'Set a daily $title target that matches your fitness level ',
                ),
                SizedBox(height: size.height * 0.1),
                Container(
                  height: size.height * 0.25,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:
                      image != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(image!, fit: BoxFit.cover),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FittedBox(
                              child: Icon(icons, color: AppColors.yelow),
                            ),
                          ),
                ),
                SizedBox(height: size.height * 0.1),
                SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.4,
                  child: Consumer(
                    builder: (context, ref, texfield) {
                      final count = ref.watch(addLogProvider);
                      countController.text = count.toString();
                      countController.selection = TextSelection.collapsed(
                        offset: countController.text.length,
                      );
                      return mytextfield(
                        keyboardType: TextInputType.number,
                        controller: countController,
                        validator: (value) {
                          return Validators.stepsValidator(value);
                        },
                        hint: "Steps count",
                        obscuretext: false,
                      );
                    },
                  ),
                ),
                smallBOldTextgrey('Steps per day'),
                SizedBox(height: size.height * 0.025),
                Row(
                  children: [
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, minus) {
                          return borderButton('-', () {
                            ref.read(addLogProvider.notifier).state--;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, minus) {
                          return borderButton('+', () {
                            ref.read(addLogProvider.notifier).state++;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                button('Set Goal', () async {
                  final user = FirebaseAuth.instance.currentUser?.uid;
                  final logSteps = int.parse(countController.text.trim());
                  await ProfileServices().addlogSteps(user!, logSteps);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyNavigationBar();
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget goalsCounter() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.35,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.transparentBackground),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: bigTextWhite('1500'),
                    ),
                    smallBOldTextWhite('kcal'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.35,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.transparentBackground),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: bigTextWhite('5'),
                    ),
                    smallBOldTextWhite('weekly'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
