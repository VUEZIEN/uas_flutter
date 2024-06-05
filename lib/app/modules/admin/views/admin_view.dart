// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';
import 'package:uas_flutter/color/color.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  final auth = Get.put(AuthController());
  final srt = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Get.toNamed(Routes.ADD_PROODUK);
              },
              child: Text('Tambah Data')),
          Obx(() => controller.status.value
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                      columns: [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Harga')),
                        DataColumn(label: Text('kategori')),
                        // DataColumn(label: Text('Jenis')),
                      ],
                      rows: List.generate(controller.data.length, (index) {
                        var nomer = index + 1;
                        Produk dt = controller.data[index];
                        return DataRow(cells: [
                          DataCell(Text('$nomer')),
                          DataCell(Text(dt.nama)),
                          DataCell(Text(dt.harga.toString())),
                          DataCell(Text(dt.kategori)),
                        ]);
                      })),
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
    );
  }
}
