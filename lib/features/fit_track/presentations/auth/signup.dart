import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/core/utiles/validators.dart';
import 'package:fit_track/features/fit_track/presentations/Profile_setup/name_setup.dart';
import 'package:fit_track/features/fit_track/presentations/auth/login.dart';
import 'package:fit_track/features/fit_track/presentations/auth/widgets.dart';

import 'package:fit_track/features/fit_track/providers/auth_provider/loginProvider.dart'
    as login;
import 'package:fit_track/features/fit_track/providers/auth_provider/signupprovider.dart'
    as signup;
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/steps_provider.dart';
import 'package:fit_track/features/shared/appbar.dart';

import 'package:fit_track/features/shared/mytextfield.dart';
import 'package:fit_track/features/shared/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpProvider = ref.watch(signup.signUpControllerProvider);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header (arrrow , help text)
                myAppbar(context),
                SizedBox(height: height * 0.03),
                bigTextWhite('Create your Account'),
                smallTextWhite('Enter your email and choose a password'),
                SizedBox(height: height * 0.05),
                //email and password
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02),
                  child: smallBOldTextWhite('Email address'),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(
                        builder: (context, ref, texfield) {
                          return mytextfield(
                            obscuretext: false,
                            onChanged: (_) {
                              final form = _formKey.currentState;
                              if (form != null) {
                                ref
                                    .read(login.isFormValidProvider.notifier)
                                    .state = form.validate();
                              }
                            },
                            validator:
                                (value) => Validators.validateEmail(value),
                            hint: 'abc@gmail.com',
                            icon: Icon(Icons.email, size: width * 0.06),
                            controller: emailController,
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          top: height * 0.018,
                        ),
                        child: smallBOldTextWhite("Password"),
                      ),
                      Consumer(
                        builder: (context, ref, textfield) {
                          final hiden = ref.watch(signup.passwordhideProvider);
                          return mytextfield(
                            obscuretext: hiden,
                            onChanged: (_) {
                              final form = _formKey.currentState;
                              if (form != null) {
                                ref
                                    .read(login.isFormValidProvider.notifier)
                                    .state = form.validate();
                              }
                            },
                            validator:
                                (value) => Validators.validatePassword(value),
                            controller: passwordController,
                            hint: 'Password must be 6 digits',
                            icon: Icon(Icons.lock, size: width * 0.06),
                            suffix: IconButton(
                              onPressed: () {
                                ref
                                    .read(signup.passwordhideProvider.notifier)
                                    .state = !hiden;
                              },
                              icon: Icon(
                                hiden ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.yelow,
                                size: width * 0.06,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                //Register button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Consumer(
                    builder: (context, ref, button) {
                      final isValid = ref.watch(login.isFormValidProvider);
                      return ElevatedButton(
                        onPressed:
                            isValid
                                ? () async {
                                  final success = await ref
                                      .read(
                                        signup
                                            .signUpControllerProvider
                                            .notifier,
                                      )
                                      .signUp(
                                        emailController.text,
                                        passwordController.text,
                                      );

                                  if (success) {
                                    ref
                                        .read(stepCountProvider.notifier)
                                        .resetBaseline();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NameSetup(),
                                      ),
                                    );
                                  } else {
                                    final error =
                                        signUpProvider.error.toString();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        elevation: 5,
                                        margin: EdgeInsets.all(16.0),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 16.0,
                                        ),
                                      ),
                                    );
                                  }
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isValid
                                  ? AppColors.yelow
                                  : AppColors.transparentBackground,
                          minimumSize: Size(width * 0.9, height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:
                            signUpProvider.isLoading
                                ? SizedBox(
                                  width: width * 0.05,
                                  height: width * 0.05,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.black,
                                  ),
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Register",
                                      style: TextStyle(fontSize: width * 0.045),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: width * 0.05,
                                    ),
                                  ],
                                ),
                      );
                    },
                  ),
                ),

                SizedBox(height: height * 0.04),
                //register decor text separted with .....
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    dots(context, MainAxisAlignment.end),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Text(
                        "or register with",
                        style: TextStyle(
                          fontSize: width * 0.03,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    dots(context, MainAxisAlignment.start),
                  ],
                ),

                SizedBox(height: height * 0.03),
                //google and apple button to sign in
                Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      signInbutton(context, 'Apple', Icons.apple),
                      signInbutton(context, 'Google', Icons.g_mobiledata),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                //already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    smallTextWhite("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: AppColors.yelow,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.yelow,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
