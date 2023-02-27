// ignore_for_file: depend_on_referenced_packages, unused_import
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:intl/intl.dart';

List _paginatedOrders = [];
List<List> _orders = [];
List columnNames = [];
final RowDataSource rDataSource = RowDataSource();
int _rowsPerPage = 10;

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
            padding: const EdgeInsets.only(left: 16),
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
    if (startIndex < _orders.length && endIndex <= _orders.length) {
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
  final List<Map> columnNames;
  final String keyName;
  final String keyColumnWidth;
  final List<List> rowsData;
  final double widgetHeight;
  const BuildSfDataGrid({
    Key? key,
    required this.columnNames,
    required this.keyName,
    required this.keyColumnWidth,
    required this.rowsData,
    required this.widgetHeight,
  }) : super(key: key);

  @override
  BSfDataGrid createState() => BSfDataGrid();
}

class BSfDataGrid extends State<BuildSfDataGrid> {
  @override
  Widget build(BuildContext context) {
    //

    _orders = widget.rowsData;
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        filterIcon: Builder(
          builder: (context) {
            String columnName = '';
            context.visitAncestorElements((element) {
              if (element is GridHeaderCellElement) {
                columnName = element.column.columnName;
              }
              return true;
            });

            var column = rDataSource.filterConditions.keys
                .where((element) => element == columnName);
            //
            Widget? icon;
            //
            if (column.isEmpty) {
              icon = const Icon(
                Icons.filter_alt_outlined,
                size: 20,
                color: Color.fromARGB(255, 167, 167, 167),
              );
            }

            return icon ??
                const Icon(
                  Icons.filter_alt_outlined,
                  size: 20,
                  color: Colors.green,
                );
          },
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: widget.widgetHeight - 200,
            child: SfDataGrid(
              onQueryRowHeight: (details) {
                return details.getIntrinsicRowHeight(details.rowIndex);
              },
              isScrollbarAlwaysShown: true,
              frozenColumnsCount: 0,
              columnWidthMode: ColumnWidthMode.fill,
              columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
              headerGridLinesVisibility: GridLinesVisibility.none,
              gridLinesVisibility: GridLinesVisibility.none,
              allowEditing: false,
              allowFiltering: true,
              allowSorting: true,
              allowMultiColumnSorting: true,
              selectionMode: SelectionMode.multiple,
              // navigationMode: GridNavigationMode.cell,
              columns: dataColumnsName,
              source: rDataSource,
            ),
          ),
          Container(
            child: SfDataPager(
              delegate: rDataSource,
              pageCount:
                  (_orders.length / _rowsPerPage).clamp(1, double.infinity),
              direction: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
