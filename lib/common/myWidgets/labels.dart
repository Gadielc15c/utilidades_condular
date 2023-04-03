import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_text_span.dart';

Text largeLabel1({
  required String text,
}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 40),
  );
}

Text normalLabel1({required String text}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 18),
  );
}

Widget labelWMandatory({
  required String textFormFieldOuterLabel,
  required bool textFormFieldObligatory,
}) {
  //
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
    child: RichText(
      softWrap: false,
      text: TextSpan(
        children: textFormFieldObligatory
            ? [textNormal(textFormFieldOuterLabel), textObligatory]
            : [textNormal(textFormFieldOuterLabel)],
      ),
    ),
  );
}
