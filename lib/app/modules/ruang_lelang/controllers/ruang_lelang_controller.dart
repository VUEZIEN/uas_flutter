// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors, avoid_print, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:uas_flutter/app/modules/add-prooduk/views/add_prooduk_view.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class RuangLelangController extends GetxController {
  String? idUser = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController nama = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController alamat = TextEditingController();
  RxString idLelang = ''.obs;
  RxBool isIkut = false.obs;
  RxBool loading = true.obs;
  List<dynamic> detailList = [];
  RxBool status = false.obs;
  final MoneyMaskedTextController harga = MoneyMaskedTextController(
    decimalSeparator: '',
    thousandSeparator: '.',
    precision: 0,
  );

  FirebaseFirestore fs = FirebaseFirestore.instance;

  void setIdLelang(String id) {
    idLelang.value = id;
    cek();
  }

  savePeserta() async {
    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference peserta = fs.collection('peserta');

    final dataPeserta = {
      "nama": nama.text,
      "nik": nik.text,
      "alamat": alamat.text,
      "id_lelang": idLelang.value,
      "id_peserta": idUser,
    };

    final psrt = await fs
        .collection('peserta')
        .where('id_peserta', isEqualTo: idUser)
        .where('id_lelang', isEqualTo: idLelang.value)
        .get();

    if (psrt.docs.isEmpty) {
      try {
        await peserta.add(dataPeserta).then((value) {
          Get.defaultDialog(middleText: 'Ya');
        });
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.defaultDialog(middleText: 'Gagal');
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Failed',
        message: 'Anda Sudah Mengikuti Lelang ini',
        duration: Duration(seconds: 2),
      ));
    }
  }

  cek() async {
    loading.value = true;
    String? idUser = FirebaseAuth.instance.currentUser?.uid;

    final psrt = await fs
        .collection('peserta')
        .where('id_peserta', isEqualTo: idUser)
        .where('id_lelang', isEqualTo: idLelang.value)
        .get();

    if (psrt.docs.isEmpty) {
      isIkut.value = false;
    } else {
      isIkut.value = true;
    }
    loading.value = false;
    detailLelang();
  }

  detailLelang() async {
    if (!loading.value) {
      if (isIkut.value) {
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
                ...doc.data(),
                "peserta": {...pesertaData!}
              });
            }

            print(detailList[0]);

            detailList.sort((a, b) => b['bid'].compareTo(a['bid']));
          }
        } catch (e) {
          print(e);
        }

        status.value = true;
      }
    }
  }

  bid(int hargaAwal) async {
    loading.value = true;
    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    final pesertaDoc = await fs
        .collection('peserta')
        .where('id_peserta', isEqualTo: idUser)
        .where('id_lelang', isEqualTo: idLelang.value)
        .get();
    final pesertaDataID = pesertaDoc.docs[0].id;

    CollectionReference detail_lelang = fs.collection('detail_lelang');

    try {
      if (detailList.isNotEmpty) {
        print('ga');
        bool isBoleh = int.parse(removeDots(harga.text)) >
            detailList
                .map((e) => e['bid'])
                .reduce((value, element) => value > element ? value : element);

        if (isBoleh) {
          await detail_lelang.add({
            "bid": int.parse(removeDots(harga.text)),
            "id_peserta": pesertaDataID,
            "id_lelang": idLelang.value
          });
          loading.value = false;
          harga.text = '';
          detailLelang();
        } else {
          Get.showSnackbar(GetSnackBar(
            title: 'Failed',
            message: 'BID Harus lebih tinggi',
            duration: Duration(seconds: 2),
          ));
          loading.value = false;
          detailLelang();
        }
      } else if (int.parse(removeDots(harga.text)) == hargaAwal) {
        print('ya');

        Get.showSnackbar(GetSnackBar(
          title: 'Failed',
          message: 'BID Harus lebih tinggi',
          duration: Duration(seconds: 2),
        ));
        loading.value = false;
      } else if (int.parse(removeDots(harga.text)) > hargaAwal) {
        await detail_lelang.add({
          "bid": int.parse(removeDots(harga.text)),
          "id_peserta": pesertaDataID,
          "id_lelang": idLelang.value
        });
        loading.value = false;
        harga.text = '';
        detailLelang();
      }
    } catch (e) {
      loading.value = false;
      Get.showSnackbar(GetSnackBar(
        title: 'Failed',
        message: 'Gagal BID',
        duration: Duration(seconds: 2),
      ));
      print(e);
    }
  }
}
