import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {

  @override 
  _ScanState createState() => new _ScanState();



}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  @override 
  void initState(){
    super.initState();
  }
  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode.rawContent;
      });
    } on PlatformException catch(e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'Camera Permission not granted';
        });
      } else {
        setState(() {
          this.barcode = 'Unkown error: $e';
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = 'null (User returned using the "back"-button before scanning anything, Result)';
      });
    }catch (e) {
      setState(() {
        this.barcode = 'Unkown error: $e';
      });
    }
  }
  
  @override 
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Code Scanner'),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RaisedButton(
              color: Colors.purple,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: scan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.scanner, size: 40,),
                  SizedBox(width:10,),
                  Column(
                    children: <Widget>[
                      Text('Camera Scan', style: TextStyle(fontSize: 20,),),
                      SizedBox(width:10,),
                      Text("Click here for scan")
                    ],
                  ),
                ],
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical:8),
              child: Text(barcode, textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
