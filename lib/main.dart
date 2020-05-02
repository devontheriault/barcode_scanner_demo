import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'scan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ScanScreen()
    );
  }
}