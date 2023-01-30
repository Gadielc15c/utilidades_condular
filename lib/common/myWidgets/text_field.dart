import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'labels.dart';

Widget searchTextField(
    {required BuildContext context,
    required String textFormFieldOuterLabel,
    required bool textFormFieldObligatory,
    int textFormMaxLines = 1}) {
  //

  return Expanded(
    child: Column(
      children: [
        TextField(
          maxLines: textFormMaxLines,
          style: const TextStyle(
            height: 1.5,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusedBorder: textOutlineBorder,
            enabledBorder: textOutlineBorder,
          ),
        ),
      ],
    ),
  );
}
