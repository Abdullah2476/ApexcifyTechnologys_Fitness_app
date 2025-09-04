import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/core/utiles/validators.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/NavigationBar.dart';
import 'package:fit_track/features/fit_track/presentations/auth/signup.dart';

import 'package:fit_track/features/fit_track/providers/auth_provider/loginProvider.dart'
    as login;
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/steps_provider.dart';
import 'package:fit_track/features/shared/appbar.dart';

import 'package:fit_track/features/shared/mytextfield.dart';
import 'package:fit_track/features/shared/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myAppbar(context),
              SizedBox(height: size.height * .05),
              bigTextWhite('Login your Account'),
              smallTextWhite('Enter your email and password'),
              SizedBox(height: size.height * 0.07),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.02),
                child: smallBOldTextWhite('Email address'),
              ),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mytextfield(
                      obscuretext: false,
                      onChanged: (_) {
                        final form = _formKey.currentState;
                        if (form != null) {
                          ref.read(login.isFormValidProvider.notifier).state =
                              form.validate();
                        }
                      },
                      validator: (value) {
                        return Validators.validateEmail(value);
                      },
                      hint: 'abc@gmail.com',
                      icon: Icon(Icons.email),
                      controller: emailController,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.02,
                        top: size.height * 0.018,
                      ),
                      child: smallBOldTextWhite("Password"),
                    ),
                    Consumer(
                      builder: (context, ref, textfield) {
                        final hiden = ref.watch(login.passwordhideProvider);
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
                          validator: (value) {
                            return Validators.validatePassword(value);
                          },
                          controller: passwordController,
                          hint: 'Password must be 6 digits',
                          icon: Icon(Icons.lock),
                          suffix: IconButton(
                            onPressed: () {
                              ref
                                  .read(login.passwordhideProvider.notifier)
                                  .state = !hiden;
                            },
                            icon: Icon(
                              hiden
                                  ? Icons.visibility
                                  : Icons.visibility_off_sharp,
                              color: AppColors.yelow,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: Consumer(
                  builder: (context, ref, button) {
                    final loginProvider = ref.watch(
                      login.LoginControllerProvider,
                    );
                    final isValid = ref.watch(login.isFormValidProvider);
                    return ElevatedButton(
                      onPressed: () async {
                        loginProvider.isLoading ? null : () {};
                        if (isValid) {
                          final success = await ref
                              .read(login.LoginControllerProvider.notifier)
                              .Login(
                                emailController.text,
                                passwordController.text,
                              );

                          if (success) {
                            ref
                                .read(stepCountProvider.notifier)
                                .resetBaseline();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyNavigationBar(),
                              ),
                            );
                          } else {
                            final error = loginProvider.error.toString();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.all(size.width * 0.04),
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.06,
                                  vertical: size.height * 0.02,
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please fix the errors in the form.',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isValid
                                ? AppColors.yelow
                                : const Color.fromARGB(15, 59, 52, 52),
                        minimumSize: Size(size.width * 0.9, size.height * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          loginProvider.isLoading
                              ? CircularProgressIndicator(
                                color: AppColors.black,
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Login "),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  smallTextWhite("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
    );
  }
}
