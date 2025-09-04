import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/add_log.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/widgets.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';

class Logpage extends StatelessWidget {
  const Logpage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              bigTextWhite('Set your Goals'),
              SizedBox(height: 50),
              goalsWidget(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddLog(
                          title: 'Steps',
                          image: ('assets/steps.png'),
                        );
                      },
                    ),
                  );
                },
                'Steps goal',
                Icons.directions_run,
              ),
              goalsWidget(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddLog(
                          title: 'Calories',
                          icons: Icons.local_fire_department,
                        );
                      },
                    ),
                  );
                },
                'Calories goal',
                Icons.local_fire_department,
              ),
              goalsWidget(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddLog(title: 'Water', icons: Icons.water_drop);
                      },
                    ),
                  );
                },
                'Water goal',
                Icons.water_drop,
              ),
              goalsWidget(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddLog(title: 'Sleep', icons: Icons.bed);
                      },
                    ),
                  );
                },
                'Sleep goal',
                Icons.bed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
