import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/providers/userinfo_provider/user_provider.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Profilepage extends ConsumerWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(currentUserStreamProvider);
    final user = userData.asData?.value;
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
              Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: 80),
                            bigTextWhite('Profile'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.6),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.transparentBackground,
                        backgroundImage: AssetImage("assets/person.png"),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      user?.name ?? ' ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Software Engineer",
                      style: TextStyle(color: Colors.white54),
                    ),
                    SizedBox(height: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.yellow),
                        foregroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Edit Profile"),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStat("Height", user?.height.toString() ?? ' '),
                  buildStat("Weight", user?.weight.toString() ?? ' '),
                  buildStat("Age", "25 yrs"),
                ],
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildBadge(Icons.local_fire_department, "Calories", "2,450"),
                  buildBadge(Icons.fitness_center, "Workouts", "85"),
                  buildBadge(Icons.water_drop, "Water", "3.2L"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget buildBadge(IconData icon, String title, String value) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.yellow),
          SizedBox(height: 8),
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
