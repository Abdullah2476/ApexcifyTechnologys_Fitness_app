// ignore_for_file: deprecated_member_use

import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/auth/login.dart';
import 'package:fit_track/features/fit_track/presentations/auth/signup.dart';
import 'package:fit_track/features/shared/buttons.dart';
import 'package:fit_track/features/shared/text_widget.dart';

import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height * 0.08, // instead of 50
                    width: size.width * 0.15, // instead of 50
                    child: Image.asset('assets/logo.png'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.translate_outlined,
                      color: AppColors.yelow,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05), // instead of 30
              Container(
                height: size.height * 0.38, // instead of 250
                width: size.width * 0.8, // instead of 300
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.yelow, AppColors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset('assets/person.png', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: size.height * 0.03), // instead of 20
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' Fit ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.yelow,
                      ),
                    ),
                    TextSpan(
                      text: 'track',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: smallTextWhite(
                  "Welcome to your personal fitness tracker! Count every step, burn calories, and watch your progress grow. Small moves add up to big results – stay active, stay healthy, and let’s reach your goals together!",
                ),
              ),
              SizedBox(height: size.height * .01),
              yellowButton('Register', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              }),
              borderButton('Log In', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
