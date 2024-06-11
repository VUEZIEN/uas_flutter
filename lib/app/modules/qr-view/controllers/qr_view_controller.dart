// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_cast, prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/modules/qr-view/model/lelang.model.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class QrViewController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool loading = false.obs;
  RxBool ada = false.obs;
  var lelangList = <Lelang>[].obs;
  RxString namaPemenang = ''.obs;

  saveToLelang(Produk dt) async {
    CollectionReference lelang = fs.collection('lelang');

    final lelangData = {
      "id_produk": dt.id,
      "id_pemenang": null,
      "keterangan": 'BELUM BERLANGSUNG'
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
          Lelang lelang =
              Lelang.fromJson(e.data() as Map<String, dynamic>, e.id);
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

  bukaLelang() async {
    CollectionReference lelang = fs.collection('lelang');

    try {
      loading.value = true;

      await lelang
          .doc(lelangList[0].id)
          .update({"keterangan": 'BERLANGSUNG'}).then((value) {
        Get.showSnackbar(GetSnackBar(
          title: 'Berhasil',
          message: 'Lelang Dibuka!',
          duration: Duration(seconds: 2),
        ));
        getDataLelang(lelangList[0].idProduk);
      });
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(
        title: 'Failed!',
        message: 'Lelang gagal dibuka',
        duration: Duration(seconds: 2),
      ));
    }
  }

  tutupLelang() async {
    loading.value = true;
    try {
      List<dynamic> detailList = [];
      final detailLelang = await fs
          .collection('detail_lelang')
          .where('id_lelang', isEqualTo: lelangList[0].id)
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
        }

        var pemenang = detailList.fold(detailList[0],
            (curr, next) => curr['bid'] > next['bid'] ? curr : next);

        String idPemenang = pemenang['id_peserta'];

        CollectionReference lelang = fs.collection('lelang');
        await lelang.doc(lelangList[0].id).update({"id_pemenang": idPemenang, "keterangan": 'PENENTUAN'});
        namaPemenang.value = pemenang['peserta']['nama'];
        loading.value = false;
      } else {
        print('ksoong');
        Get.defaultDialog(middleText: 'TIDAK BISA');
        loading.value = false;
      }
    } catch (e) {
      print(e);
    }

  }

  cek(String id) async {
    try {
      loading.value = true;
      final data =
          await fs.collection('lelang').where('id_produk', isEqualTo: id).get();

      if (data.docs.isNotEmpty) {
        // print(data.docs[0].data()['id_pemenang']);
        if (data.docs[0].data()['id_pemenang'] != null) {
          final pesertaDoc = await fs
              .collection('peserta')
              .doc(data.docs[0].data()['id_pemenang'])
              .get();

          print(pesertaDoc.data());

          namaPemenang.value = pesertaDoc.data()?['nama'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   cek();
  // }
}
