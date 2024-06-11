// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailLelangController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxString idLelang = ''.obs;
  RxBool status = false.obs;
  List<dynamic> detailList = [];

  void setIdLelang(String id) {
    idLelang.value = id;
  }

  detailLelang() async {
    status.value = false;

    try {
      detailList = [];
      final detailLelang = await fs
          .collection('detail_lelang')
          .where('id_lelang', isEqualTo: idLelang.value)
          .get();

      if (detailLelang.docs.isNotEmpty) {
        for (var doc in detailLelang.docs) {
          final detailData = doc.data();
          final pesertaDoc = await fs
              .collection('peserta')
              .doc(detailData['id_peserta'])
              .get();
          final pesertaData = pesertaDoc.data();

          detailList.add({
            ...detailData,
            "peserta": {...pesertaData!}
          });

          detailList.sort((a, b) => b['bid'].compareTo(a['bid']));
        }

        status.value = true;
      } else {
        detailList = [];
        status.value = true;
      }
    } catch (e) {
      print(e);
    }
  }
}
