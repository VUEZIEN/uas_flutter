// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/color/color.dart';

import '../controllers/edit_produk_controller.dart';

class EditProdukView extends GetView<EditProdukController> {
  Produk data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.updateVar(data);
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Produk', style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.ijoMuda,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 24),
                Obx(() => InkWell(
                      onTap: () => controller.uploadPhoto(),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          color: Colors.grey,
                          child: controller.url.value.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, size: 50),
                                    SizedBox(height: 4),
                                    Text('Klik untuk memilih')
                                  ],
                                )
                              : Image.network(
                                  controller.url.value,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                )),
                    )),
                SizedBox(height: 16),
                TextField(
                  controller: controller.nama,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller.kategori,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kategori',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: controller.harga,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Harga',
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      controller.saveProduk(data.id);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: CustomColors.ijoTua,
                        elevation: 0),
                    child: Text(
                      controller.loading.value ? 'Loading...' : 'Perbarui',
                      style:
                          TextStyle(fontSize: 18, color: CustomColors.kremMuda),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
