// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class ScanView extends StatefulWidget {
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  CameraController _controller = CameraController(autoPlay: false);
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
            FlutterWebQrcodeScanner(
              cameraDirection: CameraDirection.back,
              stopOnFirstResult: false,
              controller: _controller,
              onGetResult: (result) {
                _controller.stopVideoStream();
                     print(result);
                     Get.offAllNamed(Routes.RUANG_LELANG, arguments: result);
              },
              width: 500,
              height: 500,
            ),
            ElevatedButton(
              onPressed: () {
                // Ensure to start or resume the camera stream
                _controller.startVideoStream();
              },
              child: Text('Start Scanning'),
            ),
          ],
        ),
      ),
    );
  }
}
