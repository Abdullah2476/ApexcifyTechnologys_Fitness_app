import 'package:fit_track/features/core/theme/app_colors.dart';

import 'package:flutter/material.dart';

Widget mytextfield({
  required TextEditingController controller,
  required FormFieldValidator validator,

  required String hint,
  Icon? icon,
  required bool obscuretext,
  ValueChanged? onChanged,
  IconButton? suffix,
  TextInputType? keyboardType,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      obscureText: obscuretext,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: suffix,
        focusColor: AppColors.yelow,
        hintText: hint,

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.yelow),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
  );
}
