// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class RuangLelangController extends GetxController {
  Stream authStatus = FirebaseAuth.instance.authStateChanges();
  TextEditingController nama = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController alamat = TextEditingController();
  RxString idLelang = ''.obs;
  RxBool isIkut = false.obs;

  FirebaseFirestore fs = FirebaseFirestore.instance;

  

  savePeserta() async {
    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference peserta = fs.collection('peserta');

    final dataPeserta = {
      "nama": nama.text,
      "nik": nik.text,
      "alamat": alamat.text,
      "id_lelang": idLelang,
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
    String? idUser = FirebaseAuth.instance.currentUser?.uid;


    final psrt = await fs
        .collection('peserta')
        .where('id_peserta', isEqualTo: idUser)
        .where('id_lelang', isEqualTo: idLelang.value)
        .get();

    if (psrt.docs.isEmpty) {
      isIkut.value = false;
      print(idLelang.value);
      print('blm ikut');
    } else {
      isIkut.value = true;
      print('sudah ikut');
    }
  }
}
