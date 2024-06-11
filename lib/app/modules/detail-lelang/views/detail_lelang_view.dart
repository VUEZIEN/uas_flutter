// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/views/admin_view.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/detail_lelang_controller.dart';

class DetailLelangView extends GetView<DetailLelangController> {
  final arg = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    controller.setIdLelang(arg);
    controller.detailLelang();

    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Lelang', style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.ijoMuda,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Obx(() => controller.status.value ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Penawaran')),
                      ],
                      rows: List.generate(controller.detailList.length, (i) {
                        final dt = controller.detailList[i];

                        return DataRow(cells: [
                          DataCell(Text(
                              '${dt["peserta"]["nama"]}')),
                          DataCell(Text('${formatRupiah(dt["bid"])}')),
                        ]);
                      }),
                    ),
                  ),
                ) : CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }
}
