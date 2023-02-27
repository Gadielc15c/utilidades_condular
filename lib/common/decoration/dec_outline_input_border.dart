import 'package:flutter/material.dart';

Color textFieldBorderColor = const Color.fromARGB(255, 200, 200, 200);
double textFieldBorderWidth = 2;
BorderRadius textFieldBorderRadius = BorderRadius.circular(15);

OutlineInputBorder textOutlineBorder({
  double borderRadius = 15,
  double borderWidth = 2,
  Color borderColor = const Color.fromARGB(255, 200, 200, 200),
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(
      width: borderWidth,
      color: borderColor,
    ),
  );
}
