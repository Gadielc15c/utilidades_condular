import 'package:flutter/material.dart';
// No borrar
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// No borrar
import 'package:syncfusion_flutter_core/theme.dart';
import 'common/myWidgets/sized_boxes.dart';
import 'common/myWidgets/labels.dart';
import 'common/decoration/dec_outline_input_border.dart';
// import 'common/myWidgets/form/form_text_field_1.dart';
// import 'common/myWidgets/form/form_dropdown_button_1.dart';
// import 'common/myWidgets/form/form_datepicker.dart';
// import 'common/myWidgets/buttons.dart';
import 'common/myWidgets/build_data_grid.dart';

Widget consultaHistoricoDeAccionesTab({
  required BuildContext context,
  required Function stateChange,
  required double widgetHeight,
  required double widgetWidth,
}) {
  String keyName = "name";
  String keyColumnWidth = "columnWidth";

  List<Map> columnsName = [
    {keyName: "ID", keyColumnWidth: 60},
    {keyName: "PROYECTO", keyColumnWidth: 150},
    {keyName: "ACCION", keyColumnWidth: 120},
    {keyName: "FECHA", keyColumnWidth: 115},
    {keyName: "DESCRIPCION", keyColumnWidth: double.nan},
    {keyName: "OBSERVACION", keyColumnWidth: 200}
  ];

  List<List> rowData = [];
  for (var i = 0; i < 50; i++) {
    rowData.add([
      "ID$i",
      "Proyecto$i",
      "Accion$i",
      "Fecha$i",
      "Descripcion$i",
      "Observacion$i"
    ]);
  }

  double mySfDataGridHeight = (widgetHeight - 140).abs();

  return sizedBoxPadding(
    contextHeight: widgetHeight,
    bottom: 20,
    child: ListView(
      children: [
        Center(
          child: largeLabel1(text: "CONSULTA HISTORICO DE ACCIONES"),
        ),
        Divider(
          color: textFieldBorderColor,
        ),
        SizedBox(
          height: counterBottomPadding(
            widgetHeight: widgetHeight,
            customHeight: mySfDataGridHeight,
          ),
          child: buildSfDataGrid(
            columnsName: columnsName,
            keyName: keyName,
            keyColumnWidth: keyColumnWidth,
            rowData: rowData,
          ),
        ),
      ],
    ),
  );
}
