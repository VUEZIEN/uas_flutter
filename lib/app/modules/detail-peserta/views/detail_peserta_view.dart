// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/detail_peserta_controller.dart';

class DetailPesertaView extends GetView<DetailPesertaController> {
  final co = Get.put(DetailPesertaController());
  final idLelang = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    controller.idLelang.value = idLelang;
    controller.getPeserta();
    return Scaffold(
      appBar: AppBar(
          title: Text('Data Peserta', style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.ijoMuda,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Obx(() => controller.status.value ? Column(
                children: List.generate(controller.pesertaList.length, (i) {
                  final dt = controller.pesertaList[i];

                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.green,
                    child: Text('${dt['nama']}'),
                  );
                }),
              ) : CircularProgressIndicator())
            ],
          ),
        ),
      )
    );
  }
}
