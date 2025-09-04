import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/core/utiles/validators.dart';

import 'package:fit_track/features/fit_track/presentations/Profile_setup/weight_setup.dart';

import 'package:fit_track/features/fit_track/presentations/Profile_setup/widgets.dart';
import 'package:fit_track/features/fit_track/services/userServices/profile_services.dart';
import 'package:fit_track/features/shared/appbar.dart';
import 'package:fit_track/features/shared/mytextfield.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NameSetup extends ConsumerWidget {
  NameSetup({super.key});
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final dailyStepController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      child: Center(child: smallBOldTextYellow('Step 1/3')),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: bigTextWhite("Set Up your profile"),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: smallTextWhite('Please enter your name'),
                ),
                SizedBox(height: size.height * 0.04),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: smallBOldTextWhite('Name'),
                ),
                mytextfield(
                  controller: nameController,
                  validator: (value) {
                    return Validators.nameValidator(value);
                  },
                  hint: 'Enter name',
                  icon: Icon(Icons.person),
                  obscuretext: false,
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: smallBOldTextWhite("What's your Date of birth"),
                ),
                mytextfield(
                  controller: dobController,
                  validator: (value) {
                    return Validators.dobValidator(value);
                  },
                  hint: 'DD/MM/YYYY',
                  icon: null,
                  obscuretext: false,
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: smallBOldTextWhite("What's your Daily Steps goal"),
                ),
                mytextfield(
                  controller: dailyStepController,
                  validator: (value) {
                    return Validators.stepsValidator(value);
                  },
                  hint: 'Daily Steps goal',
                  icon: null,
                  obscuretext: false,
                ),
                SizedBox(height: size.height * 0.08),
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
                          final user = FirebaseAuth.instance.currentUser?.uid;
                          final steps = int.parse(
                            dailyStepController.text.trim(),
                          );
                          await ProfileServices().addName(
                            user!,
                            nameController.text.toString(),
                            dobController.text.toString(),
                          );

                          await ProfileServices().addSteps(user, steps);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeightSetup(),
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
