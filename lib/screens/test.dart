import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  DateTime? selectedDate1;
  DateTime? selectedDate2;

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Ngày'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate1(context),
              child: Text('Chọn Ngày 1'),
            ),
            SizedBox(height: 16),
            Text(
              'Ngày 1: ${selectedDate1 != null ? DateFormat('dd/MM/yyyy').format(selectedDate1!) : 'Chưa chọn ngày 1'}',
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _selectDate2(context),
              child: Text('Chọn Ngày 2'),
            ),
            SizedBox(height: 16),
            Text(
              'Ngày 2: ${selectedDate2 != null ? DateFormat('dd/MM/yyyy').format(selectedDate2!) : 'Chưa chọn ngày 2'}',
            ),
          ],
        ),
      ),
    );
  }
}
