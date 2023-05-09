import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/build_data_grid.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/defaul_config.dart';

import '../common/myWidgets/build_data_grid_test.dart';

class ConsultaArchv extends StatefulWidget {
  final double widgetHeight;
  final double widgetWidth;
  const ConsultaArchv({
    Key? key,
    required this.widgetHeight,
    required this.widgetWidth,
  }) : super(key: key);

  @override
  ConsultaArchvBody createState() => ConsultaArchvBody();
}

class ConsultaArchvBody extends State<ConsultaArchv> {
  Future<List<List<String>>>? _rowDataFuture;

  Future<List<List<String>>> _populateTable() async {
    var results = await spData(sp: "get_archivos");
    List<List<String>> rowData = [];
    if (results[scc]) {
      Map<String, dynamic> myContent = results[cnt];
      for (var key1 in myContent.keys) {
        var value = myContent[key1];
        Map<String, String> temp = {};
        if (value["ESTADO"] == '0') {
          continue;
        }
        for (var key2 in value.keys) {
          temp[key2] = value[key2].toString();
        }
        rowData.add([
          "${temp['COD']}",
          "${temp['AREA_REF']}",
          "${temp['COD_DEPTO']}",
          "${temp['TITULO']}",
          "${temp['PERSONA_ENT']}",
          "${temp['ARCHIVO_DIG']}",
          "${temp['FECHA_IN_D']}",
          "${temp['ARCHIVO_FISC']}",
          "${temp['NUM_COP']}"
          "${temp['FECHA_IN_F']}",
          "${temp['OBSERVACIÓN']}",
          "${temp['TIEMPO']}",
          "${temp['ESTADO']}",
        ]);
      }
    } else {
      // ignore: use_build_context_synchronously
      mySnackBar(
        context: context,
        success: false,
        successfulText: "",
        unsuccessfulText: results[err],
      );
    }
    return rowData;
  }

  @override
  void initState() {
    _rowDataFuture = _populateTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String keyName = "name";
    String keyColumnWidth = "columnWidth";

    List<Map> columnsName = [
      {keyName: "ID", keyColumnWidth: 100.0},
      {keyName: "AREA REF", keyColumnWidth: 100.0},
      {keyName: "COD. DEPTO", keyColumnWidth: 160.0},
      {keyName: "TITULO", keyColumnWidth: 160.0},
      {keyName: "DELIVERY", keyColumnWidth: 160.0},
      {keyName: "DIGITAL", keyColumnWidth: 100.0},
      {keyName: "FECHA_IN_D", keyColumnWidth: 100.0},
      {keyName: "FÍSICO", keyColumnWidth: 100.0},
      {keyName: "FECHA_IN_F", keyColumnWidth: 100.0},
      {keyName: "OBSERVACIÓN", keyColumnWidth: double.nan},
      {keyName: "TIEMPO", keyColumnWidth: 100.0},
      {keyName: "ESTADO", keyColumnWidth: 30.0},
    ];

    Future<bool> areListsEqual(
      Future<List<List<String>>>? future1,
      Future<List<List<String>>>? future2,
    ) async {
      List<List<String>> list1 = await future1 ?? [];
      List<List<String>> list2 = await future2 ?? [];

      if (list1.length != list2.length) {
        return false;
      }

      for (int i = 0; i < list1.length; i++) {
        if (!list1[i].every((element) => list2[i].contains(element))) {
          return false;
        }
      }

      return true;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildBasicTable(List<List<String>> rowData) {
      List headers = columnsName.map((column) => column[keyName]).toList();

      return SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                'Consulta de Archivos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(.0),
              child: Text(
                'Para editar usar versión de escritorio',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: headers
                    .map((header) => DataColumn(label: Text(header)))
                    .toList(),
                rows: rowData
                    .map((row) => DataRow(
                          cells: row
                              .map((cell) => DataCell(Text(cell.toString())))
                              .toList(),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    }

    Future<void> populateTableAgain() async {
      Future<List<List<String>>>? tempData;
      tempData = _populateTable();

      if (mounted) {
        if (!(await areListsEqual(tempData, _rowDataFuture))) {
          setState(() {
            _rowDataFuture = tempData;
          });
        }
      }
    }

    return sizedBoxPadding(
      contextHeight: widget.widgetHeight,
      bottom: 20,
      child: ListView(
        children: [
          Column(
            children: [
              // ...
              FutureBuilder<List<List<String>>>(
                future: _rowDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Text('No data');
                  }
                  List<List<String>> rowData = snapshot.data!;
                  return LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      if (constraints.maxWidth < 600) {
                        return _buildBasicTable(snapshot.data!);
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildSfDataGridArchivo(
                              context: context,
                              columnNames: columnsName,
                              keyName: keyName,
                              keyColumnWidth: keyColumnWidth,
                              rowsData: snapshot.data!,
                              widgetHeight: widget.widgetHeight - 300,
                              widgetWidth: widget.widgetHeight,
                              getDataAgain: populateTableAgain,
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
