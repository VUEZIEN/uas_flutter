// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/modules/qr-view/model/lelang.model.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class QrViewController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool loading = false.obs;
  RxBool ada = false.obs;
  var lelangList = <Lelang>[].obs;

  saveToLelang(Produk dt, DateTime tgl) async {
    CollectionReference lelang = fs.collection('lelang');

    final lelangData = {
      "start": DateTime.now(),
      "end": tgl,
      "id_produk": dt.id,
      "id_pemenang": null, 
    };

    try {
      await lelang.add(lelangData).then((value) {
        Get.defaultDialog(middleText: 'Ya');
      });
      Get.offAllNamed(Routes.ADMIN);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal');
    }
  }

  getDataLelang(String id) async {
    try {
      loading.value = true;
      final data =
          await fs.collection('lelang').where('id_produk', isEqualTo: id).get();
      if (data.docs.isNotEmpty) {
        lelangList.clear();

        data.docs.forEach((e) {
          Lelang lelang = Lelang.fromJson(e.data() as Map<String, dynamic>, e.id);
          lelangList.add(lelang);
        });

        loading.value = false;
        ada.value = true;
      } else {
        loading.value = false;
        ada.value = false;
      }
    } catch (e) {
      loading.value = false;
      ada.value = false;
      print('roor $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('jalan');
  }
}