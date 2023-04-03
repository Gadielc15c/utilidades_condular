import 'package:flutter/material.dart';
// No borrar
// ignore:unused_import
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// No borrar
// ignore: depend_on_referenced_packages, unused_import
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/build_data_grid.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/defaul_config.dart';

class ConsultaHistDeAcciones extends StatefulWidget {
  final double widgetHeight;
  final double widgetWidth;
  const ConsultaHistDeAcciones({
    Key? key,
    required this.widgetHeight,
    required this.widgetWidth,
  }) : super(key: key);

  @override
  ConsultaHistDeAccionesBody createState() => ConsultaHistDeAccionesBody();
}

class ConsultaHistDeAccionesBody extends State<ConsultaHistDeAcciones> {
  Future<List<List<String>>>? _rowDataFuture;

  Future<List<List<String>>> _populateTable() async {
    var results = await spData(sp: "get_actividades");
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
          String newKey = key2.toString();
          if (key2 == "ACCION_TITLE") {
            newKey = "ACCION";
          }
          if (key2 == "FK_PROYECTO") {
            newKey = "PROYECTO";
          }
          temp[newKey] = value[key2].toString();
        }
        rowData.add([
          "${temp['ID']}",
          "${temp['PROYECTO']}",
          "${temp['ACCION']}",
          "${temp['FECHA']}",
          "${temp['DESCRIPCION']}",
          "${temp['OBSERVACION']}",
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
      {keyName: "ID", keyColumnWidth: 110},
      {keyName: "PROYECTO", keyColumnWidth: 160},
      {keyName: "ACCION", keyColumnWidth: 160},
      {keyName: "FECHA", keyColumnWidth: 155},
      {keyName: "DESCRIPCION", keyColumnWidth: double.nan},
      {keyName: "OBSERVACION", keyColumnWidth: double.nan},
    ];

    return sizedBoxPadding(
      contextHeight: widget.widgetHeight,
      bottom: 20,
      child: Column(
        children: [
          Center(
            child: largeLabel1(text: "CONSULTA HISTORICO DE ACCIONES"),
          ),
          Divider(
            color: textFieldBorderColor,
          ),
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildSfDataGrid(
                    context: context,
                    columnNames: columnsName,
                    keyName: keyName,
                    keyColumnWidth: keyColumnWidth,
                    rowsData: snapshot.data!,
                    widgetHeight: widget.widgetHeight - 300,
                    widgetWidth: widget.widgetHeight,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
