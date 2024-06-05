// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';
import 'package:uas_flutter/color/color.dart';
import 'package:intl/intl.dart';
import '../controllers/admin_controller.dart';

String formatRupiah(double value) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  return formatter.format(value);
}

String capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

class AdminView extends GetView<AdminController> {
  final auth = Get.put(AuthController());
  final srt = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Produk', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 24),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      color: Colors.green,
                    ),
                    SizedBox(width: 2),
                    Text('BELUM SOLD')
                  ],
                ),
                SizedBox(width: 6),
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 2),
                    Text('SUDAH SOLD')
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Obx(() => controller.status.value
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: List.generate(controller.data.length, (index) {
                        Produk dt = controller.data[index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          width: lebar,
                          height: 70,
                          decoration: BoxDecoration(
                              color: CustomColors.kremMuda,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Container(
                                width: 15,
                                decoration: BoxDecoration(
                                    color:
                                        dt.status ? Colors.green : Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                              ),
                              Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12))),
                                        child: Image.network(dt.img, fit: BoxFit.cover,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('ID: ${dt.id} || KAT: ${dt.kategori}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
                                  SizedBox(height: 4),
                                  Text('PRODUK: ${capitalize(dt.nama)}'),
                                  Text(
                                      'HARGA: ${formatRupiah(dt.harga.toDouble())}'),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )),
            Center(
              child: IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Apakah anda yakin?',
                      middleText: 'Sign Out dari lelang online?',
                      confirm: ElevatedButton(
                          onPressed: () => auth.logout(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.ijoTua),
                          child: Text(
                            'Ya!',
                            style: TextStyle(color: Colors.white),
                          )),
                      cancel: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.kremTua),
                          onPressed: () => Get.back(),
                          child: Text('Tidak!',
                              style: TextStyle(color: Colors.white))),
                    );
                  },
                  icon: Icon(Icons.logout)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_PROODUK),
          child: Icon(Icons.add)),
    );
  }
}
