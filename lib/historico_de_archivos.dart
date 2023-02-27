import 'package:flutter/material.dart';
import 'common/myWidgets/form/form_text_field_1.dart';
import 'common/myWidgets/form/form_dropdown_button_1.dart';
import 'common/myWidgets/form/form_datepicker.dart';
import 'common/myWidgets/sized_boxes.dart';
import 'common/myWidgets/labels.dart';
import 'common/decoration/dec_outline_input_border.dart';
import 'common/myWidgets/buttons.dart';

Widget historicoDeArchivos({
  required BuildContext context,
  required Function stateChange,
  required double contextHeight,
  required double contextWidth,
}) {
  double widgetHeight = contextHeight / 7;
  double maxHeight = 170;
  double minHeight = 95;

  return sizedBoxPadding(
    contextHeight: contextHeight,
    child: Form(
      child: ListView(
        children: [
          Center(
            child: largeLabel1(text: "HISTORICO DE ARCHIVOS"),
          ),
          Divider(
            color: textFieldBorderColor,
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              children: [
                const FormDropDown1(
                  textFormFieldOuterLabel: "COD",
                  textFormFieldObligatory: true,
                  initialValue: "001",
                  items: ["001", "002"],
                ),
                sizedBoxW(),
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "Persona quien entrega",
                  textFormFieldObligatory: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              children: [
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "AREA DE REFERENCIA",
                  textFormFieldObligatory: true,
                ),
                sizedBoxW(),
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "Númeor de Copias",
                  textFormFieldObligatory: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              children: [
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "TITULO",
                  textFormFieldObligatory: true,
                ),
                sizedBoxW(),
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "Archivo Digital",
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
                  textFormFieldOuterLabel: "FECHA INGRESO DIGITAL",
                  textFormFieldObligatory: true,
                ),
                sizedBoxW(),
                const FormDatePicker1(
                  textFormFieldOuterLabel: "FECHA INGRESO FISICO",
                  textFormFieldObligatory: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              children: [
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "TIEMPO",
                  textFormFieldObligatory: true,
                ),
                sizedBoxW(),
                formTextField1(
                  context: context,
                  textFormFieldOuterLabel: "OBSERVACION",
                  textFormFieldObligatory: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: (widgetHeight).clamp(minHeight, maxHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button1(
                  buttonLabel: "Guardar",
                  buttonIcon: const Icon(Icons.save),
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
