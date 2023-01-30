import 'package:flutter/material.dart';

Color textFieldBorderColor = const Color.fromARGB(255, 200, 200, 200);
double textFieldBorderWidth = 2;
BorderRadius textFieldBorderRadius = BorderRadius.circular(15);

OutlineInputBorder textOutlineBorder = OutlineInputBorder(
  borderRadius: textFieldBorderRadius,
  borderSide: BorderSide(
    width: textFieldBorderWidth,
    color: textFieldBorderColor,
  ),
);
