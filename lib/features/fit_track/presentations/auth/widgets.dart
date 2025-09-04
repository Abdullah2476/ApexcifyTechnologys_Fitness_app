import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';

Widget signInbutton(BuildContext context, String title, IconData icon) {
  final size = MediaQuery.of(context).size;
  final height = size.height;
  final width = size.width;
  return Container(
    height: height * 0.07,
    width: width * 0.35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.yelow),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.white, size: width * 0.06),
        SizedBox(width: width * 0.02),
        smallBOldTextYellow(title),
      ],
    ),
  );
}

Widget dots(BuildContext context, MainAxisAlignment align) {
  final size = MediaQuery.of(context).size;
  final height = size.height;
  final width = size.width;
  return Expanded(
    child: Row(
      mainAxisAlignment: align,
      children: List.generate(
        10,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.005),
          width: width * 0.008,
          height: height * 0.001,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
