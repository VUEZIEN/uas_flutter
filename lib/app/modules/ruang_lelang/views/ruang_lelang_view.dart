// ignore_for_file: unnecessary_brace_in_string_interps, use_key_in_widget_constructors, unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/views/admin_view.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/ruang_lelang_controller.dart';

class RuangLelangView extends GetView<RuangLelangController> {
  final RuangLelangController co = Get.put(RuangLelangController());
  final data = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    co.setIdLelang(data);

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
              child: Obx(() => !controller.loading.value
                  ? controller.isIkut.value
                      ? Column(
                          children: [
                            Text('Ruang Lelang'),
                            Obx(() => controller.status.value
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DataTable(
                                            columns: [
                                              DataColumn(label: Text('Nama')),
                                              DataColumn(
                                                  label: Text('Penawaran')),
                                            ],
                                            rows: List.generate(
                                                controller.detailList.length,
                                                (i) {
                                              final dt =
                                                  controller.detailList[i];

                                              return DataRow(cells: [
                                                DataCell(Text(
                                                    '${dt["peserta"]["nama"]} ${dt["peserta"]["id_peserta"] == controller.idUser ? '(Anda)' : ''}')),
                                                DataCell(Text(
                                                    '${formatRupiah(dt["bid"])}')),
                                              ]);
                                            })),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: co.harga,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'BID',
                                        ),
                                      ),
                                      Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            if (!controller.loading.value) {
                                              controller.bid();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                              backgroundColor:
                                                  CustomColors.ijoTua,
                                              elevation: 0),
                                          child: Text(
                                            controller.loading.value
                                                ? 'Loading...'
                                                : 'Simpan',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: CustomColors.kremMuda),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : CircularProgressIndicator())
                          ],
                        )
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
                        )
                  : CircularProgressIndicator())),
        ));
  }
}
