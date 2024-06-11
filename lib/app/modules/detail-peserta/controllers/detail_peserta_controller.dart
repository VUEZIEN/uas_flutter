import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailPesertaController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxString idLelang = ''.obs;
  List<dynamic> pesertaList = [];
  RxBool status = false.obs;


  getPeserta() async{
    status.value = false;
    final peserta = await fs.collection('peserta').where('id_lelang', isEqualTo: idLelang.value).get();

    for(var doc in peserta.docs) {
      pesertaList.add(doc.data());
    }

    status.value = true;
  }
}
