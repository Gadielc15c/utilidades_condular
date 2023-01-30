import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'form_label_1.dart';

Widget formTextField1(
    {required BuildContext context,
    required String textFormFieldOuterLabel,
    required bool textFormFieldObligatory,
    int textFormMaxLines = 1}) {
  //

  return Expanded(
    child: Column(
      children: [
        formLabel1(
            textFormFieldOuterLabel: textFormFieldOuterLabel,
            textFormFieldObligatory: textFormFieldObligatory),
        TextFormField(
          maxLines: textFormMaxLines,
          style: const TextStyle(
            height: 1.5,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusedBorder: textOutlineBorder,
            enabledBorder: textOutlineBorder,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }

            return null;
          },
        ),
      ],
    ),
  );
}
