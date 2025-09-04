import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget myAppbar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: AppColors.white),
      ),
      Text(
        'Need Help?',
        style: TextStyle(
          color: AppColors.yelow,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.yelow,
        ),
      ),
    ],
  );
}
