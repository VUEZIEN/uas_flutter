// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class ScanView extends StatefulWidget {
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  Future<void> scanBarcode() async{
    String barcodeRes;
    try {
      barcodeRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeRes);
      Get.toNamed(Routes.RUANG_LELANG, arguments: {"id_lelang": barcodeRes});
    } on PlatformException {
      barcodeRes = 'gagal';
    }
    if(!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SCAN'),
            ElevatedButton(
              onPressed: () => scanBarcode(), 
              child: Text('START SCAN')
            )
          ],
        ),
      ),
    );
  }
}
