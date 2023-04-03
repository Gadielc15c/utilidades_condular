import 'package:flutter/material.dart';
import 'package:utilidades_condular/defaul_config.dart';

Text mandatoryTextWidget({
  required bool displayMandatoryField,
}) {
  return Text(
    displayMandatoryField ? mandatoryText : "",
    textAlign: TextAlign.left,
    style: const TextStyle(
      color: Colors.red,
    ),
  );
}
