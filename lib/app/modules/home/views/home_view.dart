// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/home_controller.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  final auth = Get.put(AuthController());
  final co = Get.put(HomeController());
  String formatRupiah(double value) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home', style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.ijoMuda,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text('lelang yang anda ikuti'),
                Obx(() => controller.status.value
                    ? Wrap(
                        spacing: 25,
                        runSpacing: 10,
                        children:
                            List.generate(controller.psrtList.length, (i) {
                          final dt = controller.psrtList[i];
                          print('======');
                          print(dt);
                          print('======');

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.RUANG_LELANG,
                                  arguments: {"id_lelang": dt["id_lelang"], "is": dt['lelang']['keterangan'], "produk": dt['produk']});
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 12, bottom: 12),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.network(
                                    dt['produk']["img"],
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
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
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('${dt['produk']["nama"]}'),
                                      Text(
                                          'Start ${formatRupiah(dt['produk']["harga"].toDouble())}'),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 4),
                                        width: double.infinity,
                                        height: 20,
                                        color: dt['lelang']['keterangan'] != 'BERLANGSUNG' ? Colors.grey : Colors.blue,
                                        child: Center(child: Text(dt['lelang']['keterangan'], style: TextStyle(color: Colors.white))),

                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    : CircularProgressIndicator()),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.SCAN);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: CustomColors.ijoTua,
                      elevation: 0),
                  child: Text(
                    'IKUT LELANG',
                    style:
                        TextStyle(fontSize: 18, color: CustomColors.kremMuda),
                  ),
                ),
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
        ));
  }
}
