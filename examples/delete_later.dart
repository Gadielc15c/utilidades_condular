import 'package:flutter/material.dart';
import 'common/myWidgets/form/form_text_field_1.dart';
import 'common/myWidgets/form/form_dropdown_button_1.dart';
import 'common/myWidgets/form/form_datepicker.dart';
import 'common/myWidgets/sized_boxes.dart';
import 'common/myWidgets/labels.dart';
import 'common/decoration/dec_outline_input_border.dart';
import 'common/myWidgets/buttons.dart';

Widget consultaHistoricoDeAccionesTab({
  required BuildContext context,
  required Function stateChange,
  required double contextHeight,
  required double contextWidth,
}) {
  List columnsName = [
    "ID",
    "PROYECTO",
    "ACCION",
    "FECHA",
    "DESCRIPCION",
    "OBSERVACION"
  ];
  List<DataColumn> dataColumnsName = columnsName
      .map(
        (x) => DataColumn(
          label: Text(
            x,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      )
      .toList();

  final scrollController = ScrollController();

  return sizedBoxPadding(
    bottom: 50.0,
    child: ListView(
      children: [
        Center(
          child: largeLabel1(text: "HISTORICO DE ACCIONES"),
        ),
        Divider(
          color: textFieldBorderColor,
        ),
        DataTable(
          columns: dataColumnsName,
          rows: const [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
              DataCell(Text('Actor')),
            ]),
          ],
        ),
      ],
    ),
  );
}















import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'common/myWidgets/sized_boxes.dart';
import 'common/myWidgets/labels.dart';
import 'common/decoration/dec_outline_input_border.dart';
// import 'common/myWidgets/form/form_text_field_1.dart';
// import 'common/myWidgets/form/form_dropdown_button_1.dart';
// import 'common/myWidgets/form/form_datepicker.dart';
// import 'common/myWidgets/buttons.dart';
import 'common/myWidgets/build_data_grid_row.dart';

Widget consultaHistoricoDeAccionesTab({
  required BuildContext context,
  required Function stateChange,
  required double contextHeight,
  required double contextWidth,
}) {
  List<String> columnsName = [
    "ID",
    "PROYECTO",
    "ACCION",
    "FECHA",
    "DESCRIPCION",
    "OBSERVACION"
  ];

  List<GridColumn> dataColumnsName = columnsName
      .map(
        (x) => GridColumn(
          columnName: x,
          label: Center(
            child: Text(
              x,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )
      .toList();

  List<List> getRowData = [];
  for (var i = 0; i < 50; i++) {
    getRowData.add([
      "ID$i",
      "Proyecto$i",
      "Accion$i",
      "Fecha$i",
      "Descripcion$i",
      "Observacion$i"
    ]);
  }

  return sizedBoxPadding(
    bottom: 20,
    child: ListView.builder(
      itemCount: 1,
      itemExtent: 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Center(
              child: largeLabel1(text: "HISTORICO DE ACCIONES"),
            ),
            Divider(
              color: textFieldBorderColor,
            ),
            SizedBox(
              height: contextHeight,
              child: SfDataGrid(
                isScrollbarAlwaysShown: true,
                frozenColumnsCount: 0,
                columnWidthMode: ColumnWidthMode.fill,
                headerGridLinesVisibility: GridLinesVisibility.none,
                gridLinesVisibility: GridLinesVisibility.none,
                allowSorting: true,
                columns: dataColumnsName,
                source: RowDataSource(
                    columnNames: columnsName, rowsData: getRowData),
              ),
            ),
          ],
        );
      },
    ),
  );
}

















