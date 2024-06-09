// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/modules/qr-view/controllers/qr_view_controller.dart';
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

  List<String> option = ['SOLD', 'BELUM SOLD'];
  String selectOption = 'BELUM SOLD';

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    controller.filterData(true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Produk', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 24),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status',
                ),
                value: selectOption,
                items: option.map((option) {
                  return DropdownMenuItem<String>(
                    value: option.toString(),
                    child: Text(option.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue == 'BELUM SOLD') {
                    controller.filterData(true);
                  }  else {
                    controller.filterData(false);
                  }
                },
              ),
              SizedBox(height: 12),
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
                        children:
                            List.generate(controller.data.length, (index) {
                          Produk dt = controller.data[index];

                          return GestureDetector(
                            onTap: () {
                              if(dt.status) {
                                Get.toNamed(Routes.QR_VIEW, arguments: dt);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.only(right: 8),
                              width: lebar,
                              height: 85,
                              decoration: BoxDecoration(
                                color: CustomColors.kremMuda,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.black.withOpacity(.1)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: dt.status
                                                ? Colors.green
                                                : Colors.grey,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft: Radius.circular(12))),
                                      ),
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12))),
                                        child: Image.network(dt.img,
                                            fit: BoxFit.cover, loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          }
                                        }),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              'ID: ${dt.id} || KAT: ${dt.kategori}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10)),
                                          SizedBox(height: 4),
                                          Text('PRODUK: ${capitalize(dt.nama)}'),
                                          Text(
                                              'HARGA: ${formatRupiah(dt.harga.toDouble())}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.EDIT_PRODUK,
                                              arguments: dt);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: 'Apakah anda yakin?',
                                            middleText:
                                                'Akan Menghapus Data ini?',
                                            confirm: ElevatedButton(
                                                onPressed: () {
                                                  controller.delete(dt.id);
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        CustomColors.ijoTua),
                                                child: Text(
                                                  'Ya!',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            cancel: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        CustomColors.kremTua),
                                                onPressed: () => Get.back(),
                                                child: Text('Tidak!',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_PROODUK),
          child: Icon(Icons.add)),
    );
  }
}
