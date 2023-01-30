import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class RowDataSource extends DataGridSource {
  RowDataSource({required List columnNames, required List<List> rowsData}) {
    for (List rd in rowsData) {
      List<DataGridCell> tempList = [];
      for (var i = 0; i < columnNames.length; i++) {
        tempList.add(
          DataGridCell(columnName: columnNames[i], value: rd[i]),
        );
      }
      dataGridRows.add(DataGridRow(cells: tempList));
      tempList = [];
    }
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Center(
        child: Text(
          textAlign: TextAlign.center,
          dataGridCell.value.toString(),
          softWrap: true,
        ),
      );
    }).toList());
  }
}

SfDataGrid buildSfDataGrid({
  required List<Map> columnsName,
  required String keyName,
  required String keyColumnWidth,
  required List<List> rowData,
}) {
  //
  List<GridColumn> dataColumnsName = [];
  for (var values in columnsName) {
    dataColumnsName.add(
      GridColumn(
        columnName: values[keyName],
        maximumWidth: values[keyColumnWidth],
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          alignment: Alignment.center,
          child: Text(
            values[keyName],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            softWrap: true,
          ),
        ),
      ),
    );
  }
  return SfDataGrid(
    onQueryRowHeight: (details) {
      return details.getIntrinsicRowHeight(details.rowIndex);
    },
    isScrollbarAlwaysShown: true,
    frozenColumnsCount: 0,
    columnWidthMode: ColumnWidthMode.fill,
    columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
    headerGridLinesVisibility: GridLinesVisibility.none,
    gridLinesVisibility: GridLinesVisibility.none,
    allowSorting: true,
    columns: dataColumnsName,
    source: RowDataSource(
      columnNames: columnsName.map((e) => e[keyName]).toList(),
      rowsData: rowData,
    ),
  );
}
