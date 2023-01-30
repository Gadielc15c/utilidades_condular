import 'package:flutter/material.dart';
import 'common/myWidgets/form/form_text_field_1.dart';
import 'common/myWidgets/form/form_dropdown_button_1.dart';
import 'common/myWidgets/form/form_datepicker.dart';
import 'common/myWidgets/sized_boxes.dart';
import 'common/myWidgets/labels.dart';
import 'common/decoration/dec_outline_input_border.dart';
import 'common/myWidgets/buttons.dart';

Widget historicoDeAcciones({
  required BuildContext context,
  required Function stateChange,
  required double contextHeight,
  required double contextWidth,
}) {
  double widgetHeight = contextHeight / 5;
  double maxHeight = 170;
  double minHeight = 95;

  return sizedBoxPadding(
    contextHeight: contextHeight,
    child: Form(
      child: ListView(
        children: [
          Center(
            child: largeLabel1(text: "HISTORICO DE ACCIONES"),
          ),
          Divider(
            color: textFieldBorderColor,
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              children: [
                const FormDropDown1(
                  textFormFieldOuterLabel: "Proyecto",
                  textFormFieldObligatory: true,
                  initialValue: "Item 1",
                  items: ["Item 1", "Item 2"],
                ),
                sizedBoxW(),
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "Acción",
                  textFormFieldObligatory: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              children: [
                const FormDatePicker1(
                  textFormFieldOuterLabel: "Fecha",
                  textFormFieldObligatory: true,
                ),
                sizedBoxW(),
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "Observación",
                  textFormFieldObligatory: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight + 48, maxHeight),
            child: Row(
              children: [
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "Descripción",
                  textFormFieldObligatory: true,
                  textFormMaxLines: 3,
                )
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Button1(
                  buttonLabel: "Guardar",
                  buttonIcon: Icon(Icons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
