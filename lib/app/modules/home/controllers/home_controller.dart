import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String? idUser = FirebaseAuth.instance.currentUser?.uid;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = false.obs;
  List<dynamic> psrtList = [];

  getData() async {
    status.value = false;
    final psrt = await fs
        .collection('peserta')
        .where('id_peserta', isEqualTo: idUser)
        .get();

    for (var doc in psrt.docs) {
      final psrtData = doc.data();
      final lelangDoc = await fs.collection('lelang').doc(doc.data()['id_lelang']).get();
      final lelangData = lelangDoc.data();

      if (lelangData != null) {
        final produkDoc = await fs.collection('produk').doc(lelangData['id_produk']).get();
        final produkData = produkDoc.data();

        if(lelangData['id_pemenang'] != null) {
          // print(lelangData['id_pemenang']);
          final pesertaMenang = await fs.collection('peserta').doc(lelangData['id_pemenang']).get();


          print(pesertaMenang.data());

          psrtList.add({
            ...psrtData,
            "produk": {...produkData!},
            "lelang": {...lelangData},
            "pemenang": pesertaMenang.data()?['id_peserta']
          });
        } else {
          psrtList.add({
            ...psrtData,
            "produk": {...produkData!},
            "lelang": {...lelangData},
            "pemenang": null
          });
        }

      }
    }

    status.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
