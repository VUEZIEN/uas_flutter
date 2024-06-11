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
                Obx(() => controller.status.value
                    ? Column(
                        children:
                            List.generate(controller.pesertaList.length, (i) {
                          final dt = controller.pesertaList[i];
                          print(dt);

                          return Container(
                            margin: EdgeInsets.only(bottom: 12, top: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${dt['nama']}', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                                ),),
                                 Text('${dt['id_peserta']}', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                                ),),
                              ],
                            ),
                          );
                        }),
                      )
                    : CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }
}
