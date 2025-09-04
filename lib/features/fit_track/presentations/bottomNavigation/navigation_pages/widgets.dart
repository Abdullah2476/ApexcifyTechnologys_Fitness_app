import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';

Widget caloriesCard(String title, String amount, String unit, IconData icon) {
  return Container(
    height: 100,
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 18, 17, 17),
      border: Border.all(color: AppColors.transparentStroke),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 18,
                ),
              ),
              smallTextWhite(unit),
            ],
          ),
          Icon(icon, color: AppColors.yelow, opticalSize: 12, size: 30),
        ],
      ),
    ),
  );
}

Widget goalsWidget(VoidCallback onTap, String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.transparentStroke),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon, color: AppColors.yelow),
              title: smallBOldTextWhite(title),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
