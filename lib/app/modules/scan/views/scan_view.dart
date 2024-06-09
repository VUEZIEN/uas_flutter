// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Obx(() => Text(
                controller.scannedCode.value.isEmpty
                  ? 'Scan a QR code'
                  : 'Scanned code: ${controller.scannedCode.value}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
