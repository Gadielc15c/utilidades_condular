// ignore_for_file: depend_on_referenced_packages, unused_import
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/buttons.dart';
import 'package:utilidades_condular/common/myWidgets/text_field.dart';
import 'package:utilidades_condular/common/myWidgets/notifications.dart';
import 'package:utilidades_condular/common/myFunctions/list_related.dart';

List<List> _paginatedOrders = [];
List<List> _orders = [];
List<List> _originalOrders = [];
List columnNames = [];
RowDataSource rDataSource = RowDataSource();
int _rowsPerPage = 10;
DataPagerController _dataPagerController = DataPagerController();
DataGridController _dataGridController = DataGridController();
double _numPages = (_orders.length / _rowsPerPage).ceilToDouble();

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
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              textAlign: TextAlign.left,
              dataGridCell.value.toString(),
              softWrap: true,
            ),
          ),
        ],
      );
    }).toList());
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

class BuildSfDataGrid extends StatefulWidget {
  final BuildContext context;
  final List<Map> columnNames;
  final String keyName;
  final String keyColumnWidth;
  final List<List> rowsData;
  final double widgetHeight;
  final double widgetWidth;
  //
  const BuildSfDataGrid({
    Key? key,
    required this.context,
    required this.columnNames,
    required this.keyName,
    required this.keyColumnWidth,
    required this.rowsData,
    required this.widgetHeight,
    required this.widgetWidth,
  }) : super(key: key);

  @override
  BSfDataGrid createState() => BSfDataGrid();
}

class BSfDataGrid extends State<BuildSfDataGrid> {
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
    setState(() {
      _numPages = (_orders.length / _rowsPerPage)
          .ceilToDouble()
          .clamp(1, double.infinity);
    });
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
    setState(() {
      _orders = searchedOrders;
      _updateAndPaginateOrders();
    });
  }

  List<DataGridRow> selectedRows = [];

  Future<void> deleteSelectedRows() async {
    int someLength = _dataGridController.selectedRows.length;
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

    setState(() {
      List<String> searchedList = [];
      if (_originalOrders.length != searchedList.length) {
        searchedList = _orders.map((e) => e.join()).toList();
      }

      selectedRows = _dataGridController.selectedRows;
      List<String> selectedRowsTemp = [];

      for (var s in selectedRows) {
        selectedRowsTemp
            .add(s.getCells().map((e) => e.value.toString()).toList().join());
      }

      findListInListOfListAndRemoveIt(_originalOrders, selectedRowsTemp);
      if (searchedList.isNotEmpty) {
        findListInListOfListAndRemoveIt(_orders, selectedRowsTemp);
      }

      selectedRows = [];

      _updateAndPaginateOrders();
    });
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            alignment: Alignment.centerRight,
            child: Center(
              child: Text(
                values[widget.keyName],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
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
                      onPressed: () => {},
                    ),
                    sizedBoxW(width: 10),
                    Button1(
                      buttonLabel: "Eliminar",
                      disableButtonIcon: true,
                      onPressed: () => deleteSelectedRows(),
                    )
                  ],
                ),
                SizedBox(
                  height: widget.widgetHeight
                      .clamp(0, (widget.widgetHeight).abs() + 1),
                  child: SfDataGrid(
                    controller: _dataGridController,
                    allowPullToRefresh: true,
                    onQueryRowHeight: (details) {
                      return details.getIntrinsicRowHeight(details.rowIndex);
                    },
                    isScrollbarAlwaysShown: true,
                    frozenColumnsCount: 0,
                    columnWidthMode: ColumnWidthMode.fill,
                    columnWidthCalculationRange:
                        ColumnWidthCalculationRange.allRows,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    gridLinesVisibility: GridLinesVisibility.none,
                    allowSorting: true,
                    allowMultiColumnSorting: true,
                    selectionMode: SelectionMode.multiple,
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
                  controller: _dataPagerController,
                  delegate: rDataSource,
                  pageCount: _numPages,
                  direction: Axis.horizontal,
                ),
                Row(
                  children: [
                    Expanded(
                      child: sizedBoxW(),
                    ),
                    Button1(
                      buttonLabel: "Enviar Reporte",
                      buttonIcon: const Icon(Icons.abc),
                      disableButtonIcon: true,
                      onPressed: () => {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
