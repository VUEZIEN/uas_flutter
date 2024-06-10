// ignore_for_file: unnecessary_brace_in_string_interps, use_key_in_widget_constructors, unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/ruang_lelang_controller.dart';

class RuangLelangView extends GetView<RuangLelangController> {
  // final data = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    controller.idLelang.value = 'BCY6t3E7tX16nNoyEsvs';
    controller.cek();

    return Scaffold(
        appBar: AppBar(
          title: Text('Ruang Lelang', style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.ijoMuda,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => controller.isIkut.value
                    ? Text('Sudah ikut')
                    : Column(
                        children: [
                          SizedBox(height: 24),
                          Text('Data Diri', style: TextStyle(fontSize: 34)),
                          SizedBox(height: 18),
                          TextField(
                            controller: controller.nama,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama',
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: controller.nik,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'NIK',
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: controller.alamat,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Alamat',
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              controller.savePeserta();
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: CustomColors.ijoTua,
                                elevation: 0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 18, color: CustomColors.kremMuda),
                            ),
                          )
                        ],
                      ),
              )),
        ));
  }
}
