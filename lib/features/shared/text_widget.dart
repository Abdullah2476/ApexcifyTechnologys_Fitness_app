import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget bigTextWhite(String text) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: AppColors.white,
    ),
  );
}

Widget bigTextexpanded(String text) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColors.white,
    ),
  );
}

Widget bigTextgrey(String text) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.grey,
    ),
  );
}

Widget bigTextyellow(String text) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: AppColors.yelow,
    ),
  );
}

Widget bigTextblack(String text) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: AppColors.black,
    ),
  );
}

Widget smallTextWhite(String text) {
  return Text(text, style: TextStyle(color: AppColors.white, fontSize: 13));
}

Widget smallBOldTextWhite(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.white,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget smallBOldTextgrey(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget smallBOldTextYellow(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.yelow,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
  );
}
