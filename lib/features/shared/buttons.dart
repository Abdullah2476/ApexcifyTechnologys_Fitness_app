import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget yellowButton(String text, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.yelow,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    ),
  );
}

Widget borderButton(String text, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          border: Border.all(color: AppColors.yelow),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.yelow,
            ),
          ),
        ),
      ),
    ),
  );
}
