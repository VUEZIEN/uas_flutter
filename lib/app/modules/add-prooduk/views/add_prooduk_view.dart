// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/add_prooduk_controller.dart';

String removeDots(String input) {
  return input.replaceAll('.', '');
}

class AddProodukView extends GetView<AddProodukController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Produk', style: TextStyle(color: Colors.white)),
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
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                      ),
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
                      if (!controller.loading.value) {
                        controller.saveProduk();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: CustomColors.ijoTua,
                        elevation: 0),
                    child: Text(
                      controller.loading.value ? 'Loading...' : 'Simpan',
                      style:
                          TextStyle(fontSize: 18, color: CustomColors.kremMuda),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
