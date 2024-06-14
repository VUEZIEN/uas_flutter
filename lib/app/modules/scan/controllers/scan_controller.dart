// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class ScanController extends GetxController {
//   var scannedCode = ''.obs;

//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? qrViewController;

//   void onQRViewCreated(QRViewController controller) {
//     qrViewController = controller;
//     controller.scannedDataStream.listen((scanData) {
//       if (scanData.code != null) {
//         scannedCode.value = scanData.code!;
//       } else {
//         scannedCode.value = '';
//       }
//     });
//   }

//   @override
//   void onClose() {
//     qrViewController?.dispose();
//     super.onClose();
//   }
// }
