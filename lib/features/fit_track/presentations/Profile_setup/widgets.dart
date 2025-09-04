import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';

Widget buttonBorder(String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.yelow),
      ),
      child: Center(child: bigTextyellow(text)),
    ),
  );
}

Widget button(String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.yelow,
      ),
      child: Center(child: bigTextblack(text)),
    ),
  );
}
