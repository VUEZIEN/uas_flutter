// ignore_for_file: empty_catches, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:uas_flutter/app/modules/add-prooduk/views/add_prooduk_view.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class AddProodukController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  TextEditingController nama = TextEditingController();
  TextEditingController kategori = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController img = TextEditingController();
  final MoneyMaskedTextController harga = MoneyMaskedTextController(
    decimalSeparator: '',
    thousandSeparator: '.',
    precision: 0,
  );
  RxString url = ''.obs;
  RxString name = ''.obs;
  RxBool loading = false.obs;

  uploadPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}.${result.files.first.extension}';

      url.value = fileName;
      name.value = fileName;

      FirebaseStorage st = FirebaseStorage.instance;

      try {
        await st.ref("product/$fileName").putData(fileBytes);
        final dataUrl = await st.ref("product/$fileName").getDownloadURL();
        url.value = dataUrl;
        img.text = dataUrl;
      } catch (e) {}
    } else {
      // User canceled the picker
      Get.showSnackbar(GetSnackBar(
        title: 'Failed',
        message: 'Gagala mrngupload',
        duration: Duration(seconds: 2),
      ));
    }
  }

  saveProduk() async {
    CollectionReference produk = fs.collection('produk');

    if (nama.text.isNotEmpty &&
        harga.text.isNotEmpty &&
        kategori.text.isNotEmpty &&
        img.text.isNotEmpty) {
      final produkData = {
        "nama": nama.text.toLowerCase(),
        "harga": int.parse(removeDots(harga.text)),
        "kategori": kategori.text.toLowerCase(),
        "img": url.value,
        "status": 'BELUM SOLD'
      };

      try {
        loading.value = true;
        await produk.add(produkData).then((value) {
          Get.defaultDialog(middleText: 'Ya');
        });
        Get.offAllNamed(Routes.ADMIN);
        loading.value = false;
      } catch (e) {
        loading.value = false;
        Get.defaultDialog(middleText: 'Gagal');
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Gagal!',
        message: 'Harap isi semua bidang!',
        duration: Duration(seconds: 2),
      ));
    }
  }
}
