// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/qr_view_controller.dart';

class QrViewView extends GetView<QrViewController> {
  final co = Get.put(QrViewController());
  Produk data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.getDataLelang(data.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('QR', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => controller.ada.value
                            ? Obx(() => QrImageView(
                                  data: controller.lelangList[0].id,
                                  version: QrVersions.auto,
                                  size: 200,
                                  gapless: false,
                                ))
                            : Container(
                                width: 200,
                                height: 200,
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    'BUKA LELANG UNTUK MENDAPATKAN KODE QR',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: 16),
                      Obx(
                        () => controller.ada.value
                            ? Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.DETAIL_LELANG);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 50),
                                        backgroundColor: CustomColors.ijoTua,
                                        elevation: 0),
                                    child: Text(
                                      'Detail lelang',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColors.kremMuda),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.DETAIL_PESERTA, arguments: controller.lelangList[0].id);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 50),
                                        backgroundColor: CustomColors.ijoTua,
                                        elevation: 0),
                                    child: Text(
                                      'Data Peserta',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColors.kremMuda),
                                    ),
                                  )
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now().add(Duration(days: 1)),
                                    firstDate:
                                        DateTime.now().add(Duration(days: 1)),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    // Save to lelang with the selected date
                                    controller.saveToLelang(data, pickedDate);
                                    print(pickedDate);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    backgroundColor: CustomColors.ijoTua,
                                    elevation: 0),
                                child: Text(
                                  'Buka Lelang',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: CustomColors.kremMuda),
                                ),
                              ),
                      )
                    ],
                  )),
          )),
    );
  }
}
