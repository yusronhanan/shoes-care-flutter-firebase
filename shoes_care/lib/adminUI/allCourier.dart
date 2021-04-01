import 'package:flutter/material.dart';

class AllCourierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllCourierPageState();
  }
}

class AllCourierPageState extends State<AllCourierPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Courier Data'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            header: Text('Courier Data'),
            rowsPerPage: 2,
            showCheckboxColumn: false,
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone Number')),
              DataColumn(label: Text('Address')),
              DataColumn(label: Text('NOPOL')),
            ],
            source: _DataSource(context),
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.courierId,
    this.courierName,
    this.courierEmail,
    this.courierPhone,
    this.courierAddress,
    this.courierNOPOL,
  );

  final String courierId;
  final String courierName;
  final String courierEmail;
  final String courierPhone;
  final String courierAddress;
  final String courierNOPOL;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    //TO DO: LOAD DATA FROM FIRESTORE HERE
    _rows = <_Row>[
      _Row('DOC_ID1', 'Dummy1', 'dummy1@gmail.com', '0800001', 'Dummy 1 Street',
          'D 001 DK'),
      _Row('DOC_ID2', 'Dummy2', 'dummy2@gmail.com', '0800002', 'Dummy 2 Street',
          'D 002 B'),
      _Row('DOC_ID3', 'Dummy3', 'dummy3@gmail.com', '0800003', 'Dummy 3 Street',
          'D 003 C'),
      _Row('DOC_ID4', 'Dummy4', 'dummy4@gmail.com', '0800004', 'Dummy 4 Street',
          'D 004 A'),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      // selected: row.selected,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
      cells: [
        DataCell(Text(row.courierName)),
        DataCell(Text(row.courierEmail)),
        DataCell(Text(row.courierPhone)),
        DataCell(Text(row.courierAddress)),
        DataCell(Text(row.courierNOPOL)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
