import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/services/splash_services.dart';
import 'package:fit_track/features/shared/text_widget.dart';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashscreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(
            startAngle: 0,
            endAngle: 35,
            center: Alignment.topRight,
            tileMode: TileMode.decal,

            colors: [AppColors.black, AppColors.yelow],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 180,
                width: 300,

                child: Image.asset('assets/logo.png', fit: BoxFit.contain),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [bigTextyellow('Fit'), bigTextWhite(' Track')],
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(color: AppColors.yelow),
          ],
        ),
      ),
    );
  }
}
