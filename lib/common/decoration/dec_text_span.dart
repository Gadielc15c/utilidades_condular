import 'package:flutter/material.dart';

double fontSize = 16;

TextSpan textNormal(String textFormFieldOuterLabel) {
  return TextSpan(
    text: textFormFieldOuterLabel,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextSpan textObligatory = TextSpan(
  text: "*",
  style: TextStyle(
    fontSize: fontSize,
    color: Colors.red,
  ),
);
