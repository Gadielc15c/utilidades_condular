// ignore_for_file: depend_on_referenced_packages, unused_import, use_build_context_synchronously
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';
import 'package:utilidades_condular/common/myFunctions/format_logs.dart';
import 'package:utilidades_condular/common/myFunctions/get_datetime_utc.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/buttons.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/common/myWidgets/text_field.dart';
import 'package:utilidades_condular/common/myWidgets/my_show_dialog.dart';
import 'package:utilidades_condular/common/myFunctions/list_related.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/pages/historico_de_acciones.dart';

List<List> _paginatedOrders = [];
List<List> _orders = [];
List<List> _originalOrders = [];
List columnNames = [];
double _numPages = (_orders.length / _rowsPerPage).ceilToDouble();
int _rowsPerPage = 10;
RowDataSource rDataSource = RowDataSource();
DataPagerController dataPagerController = DataPagerController();
DataGridController dataGridController = DataGridController();

List<Widget> createCellsRow({
  required DataGridRow row,
}) {
  List<Column> temp = [];
  int count = 0;
  for (var dataGridCell in row.getCells()) {
    String txt = dataGridCell.value.toString();
    if (count == 5 || count == 7) {
      txt = defaultSelectionOptions[txt] ?? "1";
    }
    count++;
    temp.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              textAlign: TextAlign.left,
              txt,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  return temp;
}

class RowDataSource extends DataGridSource {
  RowDataSource() {
    _paginatedOrders = _orders
        .getRange(0, _orders.length.clamp(0, 19))
        .toList(growable: false);
    buildDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;
  //
  // handles the data of each row
  //
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: createCellsRow(row: row),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    if (startIndex <= _orders.length) {
      if (endIndex > _orders.length) {
        endIndex = _orders.length;
        if (startIndex == endIndex) {
          startIndex = startIndex - 1;
          if (startIndex < 0) {
            startIndex = 0;
          }
        }
      }
      _paginatedOrders =
          _orders.getRange(startIndex, endIndex).toList(growable: false);
      buildDataGridRows();
      notifyListeners();
    } else {
      _paginatedOrders = [];
    }

    return true;
  }

  void buildDataGridRows() {
    dataGridRows = _paginatedOrders.map<DataGridRow>((dataGridRow) {
      final List<DataGridCell> cells = [];
      for (var i = 0; i < columnNames.length; i++) {
        cells.add(
          DataGridCell(columnName: columnNames[i], value: dataGridRow[i]),
        );
      }
      return DataGridRow(cells: cells);
    }).toList(growable: false);
  }
}

class BuildSfDataGridArchivo extends StatefulWidget {
  final BuildContext context;
  final List<Map> columnNames;
  final String keyName;
  final String keyColumnWidth;
  final List<List> rowsData;
  final double widgetHeight;
  final double widgetWidth;
  final VoidCallback getDataAgain;
  //
  const BuildSfDataGridArchivo({
    Key? key,
    required this.context,
    required this.columnNames,
    required this.keyName,
    required this.keyColumnWidth,
    required this.rowsData,
    required this.widgetHeight,
    required this.widgetWidth,
    required this.getDataAgain,
  }) : super(key: key);

  @override
  BSfDataGrid createState() => BSfDataGrid();
}

class BSfDataGrid extends State<BuildSfDataGridArchivo> {
  // Handles search
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _orders = widget.rowsData;
    _originalOrders = _orders;
    _updateNumPages();
  }

  void _updateNumPages() {
    if (mounted) {
      setState(() {
        _numPages = (_orders.length / _rowsPerPage)
            .ceilToDouble()
            .clamp(1, double.infinity);
      });
    }
  }

  void _updateAndPaginateOrders() {
    _paginatedOrders = _orders
        .getRange(0, _rowsPerPage.clamp(0, _orders.length))
        .toList(growable: false);
    rDataSource.buildDataGridRows();
    rDataSource.notifyListeners();
    _updateNumPages();
  }

  void sortAndRemove(List indeces, List someList) {
    indeces.sort();
    indeces = indeces.reversed.toList();
    if (someList.isNotEmpty) {
      for (int index in indeces) {
        someList.removeAt(index);
      }
    }
  }

  void _updateSearch(List<List> searchedOrders) {
    if (mounted) {
      setState(() {
        _orders = searchedOrders;
        _updateAndPaginateOrders();
      });
    }
  }

  List<DataGridRow> selectedRows = [];

  Future<void> updateSelectedRowsArchivos() async {
    List<DataGridRow>? selectedRows = dataGridController.selectedRows;
    if (selectedRows.isNotEmpty && selectedRows.length == 1) {
      Map<String, dynamic> rowMap = {};
      for (var row in selectedRows) {
        for (var cell in row.getCells()) {
          rowMap[cell.columnName] = cell.value;
        }
      }

      await showUpdateArchivoDialog(
        context: context,
        idCode: rowMap["ID"],
        areaRefText: rowMap['AREA REF'],
        codDeptoText: rowMap['COD. DEPTO'],
        tituloText: rowMap['TITULO'],
        personaEntText: rowMap['DELIVERY'],
        numCopText: rowMap['NUM_COP'],
        archivoDigText: rowMap['DIGITAL'],
        fechaInDText: rowMap['FECHA_IN_D'],
        archivoFiscText: rowMap['FISICO'],
        fechaInFText: rowMap['FECHA_IN_F'],
        observacionText: rowMap['OBSERVACION'],
        tiempoText: rowMap['TIEMPO'],
      );
      widget.getDataAgain();
    } else {
      mySnackBar(
        context: context,
        success: false,
        successfulText: "",
        unsuccessfulText: "No se seleccionó una fila para editar.",
      );
    }
  }

  Future<void> deleteSelectedRowsArchivos() async {
    int someLength = dataGridController.selectedRows.length;
    if (someLength > 0) {
      bool confirmDeletion = await showDeleteConfirmationDialog(
        context: context,
        textTitulo: "¿Estás seguro?",
        textContexto: someLength > 1
            ? "Se borrarán $someLength registros."
            : "Se borrará 1 registro.",
        textBotonAceptar: "Borrar",
      );
      if (confirmDeletion == false) {
        return;
      }
    }
    List<DataGridRow>? selectedRowsTemp = dataGridController.selectedRows;
    if (selectedRowsTemp.isNotEmpty && selectedRowsTemp.length == 1) {
      Map<String, dynamic> rowMap = {};
      for (var row in selectedRowsTemp) {
        for (var cell in row.getCells()) {
          rowMap[cell.columnName] = cell.value;
        }
      }
      var results = await deleteData(table: "ARCHIVOS", id: rowMap["ID"]);
      mySnackBar(
        context: context,
        success: results[scc],
        successfulText: "Se eliminó exitosamente",
        unsuccessfulText: results[err],
      );
      if (!results[scc]) {
        return;
      } else {
        await insertData(
          table: "LOGS",
          values: [
            await getUser(context) ?? "",
            typeDelete,
            "ARCHIVOS",
            "",
            stringForLogs([
              "COD: ${rowMap['ID']}",
              "AREA_REF: ${rowMap['AREA_REF']}",
              "COD_DEPTO: ${rowMap['COD_DEPTO']}",
              "TITULO: ${rowMap['TITULO']}",
              "PERSONA_ENT: ${rowMap['PERSONA_ENT']}",
              "NUM_COP: ${rowMap['NUM_COP']}",
              "ARCHIVO_DIG: ${rowMap['ARCHIVO_DIG']}",
              "FECHA_IN_D: ${rowMap['FECHA_IN_D']}",
              "ARCHIVO_FISC: ${rowMap['ARCHIVO_FISC']}",
              "FECHA_IN_F: ${rowMap['FECHA_IN_F']}",
              "OBSERVACION: ${rowMap['OBSERVACION']}",
              "TIEMPO: ${rowMap['TIEMPO']}",
              "ESTADO: ${0}",
            ]),
            getDateTime(),
          ],
        );
      }

      if (mounted) {
        setState(() {
          List<String> searchedList = [];
          if (_originalOrders.length != searchedList.length) {
            searchedList = _orders.map((e) => e.join()).toList();
          }

          selectedRows = dataGridController.selectedRows;
          List<String> selectedRowsTemp = [];

          for (var s in selectedRows) {
            selectedRowsTemp.add(
                s.getCells().map((e) => e.value.toString()).toList().join());
          }

          findListInListOfListAndRemoveIt(_originalOrders, selectedRowsTemp);
          if (searchedList.isNotEmpty) {
            findListInListOfListAndRemoveIt(_orders, selectedRowsTemp);
          }

          selectedRows = [];

          _updateAndPaginateOrders();
        });
      }
    } else {
      mySnackBar(
        context: context,
        success: false,
        successfulText: "",
        unsuccessfulText: "No se seleccionó una fila para eliminar.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    columnNames = widget.columnNames.map((e) => e[widget.keyName]).toList();

    List<GridColumn> dataColumnsName = [];
    //
    // handles the header of each column
    //
    for (var values in widget.columnNames) {
      dataColumnsName.add(
        GridColumn(
          filterPopupMenuOptions:
              const FilterPopupMenuOptions(canShowSortingOptions: false),
          columnName: values[widget.keyName],
          maximumWidth: values[widget.keyColumnWidth],
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            alignment: Alignment.centerRight,
            child: Center(
              child: Text(
                values[widget.keyName],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );
    }
    //

    return SfDataGridTheme(
      data: SfDataGridThemeData(
        selectionColor: const Color.fromARGB(255, 235, 235, 235),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: SearchTextField(
                        searchController: searchController,
                        onUpdateSearch: _updateSearch,
                        textFormFieldOuterLabel: "Buscar",
                        textFormFieldObligatory: false,
                        hintText: "Buscar",
                        orders: _originalOrders,
                      ),
                    ),
                    Expanded(child: sizedBoxW()),
                    Button1(
                      buttonLabel: "Editar",
                      disableButtonIcon: true,
                      onPressed: () => updateSelectedRowsArchivos(),
                    ),
                    sizedBoxW(width: 10),
                    Button1(
                      buttonLabel: "Eliminar",
                      disableButtonIcon: true,
                      onPressed: () => deleteSelectedRowsArchivos(),
                    )
                  ],
                ),
                SizedBox(
                  height: widget.widgetHeight
                      .clamp(0, (widget.widgetHeight).abs() + 1),
                  child: SfDataGrid(
                    controller: dataGridController,
                    onSelectionChanged: (addedRows, removedRows) => {
                      dataGridController.selectedRows = addedRows,
                    },
                    allowPullToRefresh: true,
                    onQueryRowHeight: (details) {
                      return details.getIntrinsicRowHeight(details.rowIndex);
                    },
                    isScrollbarAlwaysShown: true,
                    frozenColumnsCount: 0,
                    columnWidthMode: ColumnWidthMode.auto, // Cambia esta línea
                    columnWidthCalculationRange:
                        ColumnWidthCalculationRange.allRows,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    gridLinesVisibility: GridLinesVisibility.none,
                    allowSorting: true,
                    allowMultiColumnSorting: true,
                    selectionMode: SelectionMode.single,
                    columns: dataColumnsName,
                    source: rDataSource,
                    footerFrozenRowsCount: 1,
                    footer: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _orders.length == _originalOrders.length
                              ? '${_orders.length} registros'
                              : '${_orders.length} de ${_originalOrders.length} registros',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 140, 140, 140),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SfDataPager(
                  controller: dataPagerController,
                  delegate: rDataSource,
                  pageCount: _numPages,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
