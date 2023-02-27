import 'package:flutter/material.dart';
// No borrar
// ignore:unused_import
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// No borrar
// ignore: depend_on_referenced_packages, unused_import
import 'package:syncfusion_flutter_core/theme.dart';
import 'common/myWidgets/sized_boxes.dart';
import 'common/myWidgets/labels.dart';
import 'common/decoration/dec_outline_input_border.dart';
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
    {keyName: "ID", keyColumnWidth: 110},
    {keyName: "PROYECTO", keyColumnWidth: 180},
    {keyName: "ACCION", keyColumnWidth: 160},
    {keyName: "FECHA", keyColumnWidth: 155},
    {keyName: "DESCRIPCION", keyColumnWidth: double.nan},
    {keyName: "OBSERVACION", keyColumnWidth: double.nan},
  ];

  List<List<String>> rowData = [];
  for (var i = 0; i < 50; i++) {
    rowData.add([
      "ID$i",
      "Proyecto$i",
      "Accion$i",
      "Fecha$i",
      "Descripcion$i",
      "Observacion$i",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildSfDataGrid(
                context: context,
                columnNames: columnsName,
                keyName: keyName,
                keyColumnWidth: keyColumnWidth,
                rowsData: rowData,
                widgetHeight: widgetHeight - 300,
                widgetWidth: widgetWidth,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
