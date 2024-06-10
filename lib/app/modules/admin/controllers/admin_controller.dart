// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';

class AdminController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = false.obs;
  List<Produk> data = [];
  
  getProduct() async {
    try {
      status.value = false;
      final produk = await fs.collection("produk").orderBy('harga').get();

      print(produk);

      if (produk.docs.isNotEmpty) {
        produk.docs.map((e) {
          Produk productList = Produk.fromJson(Map.from(e.data()), e.id);
          data.add(productList);
        }).toList();
        status.value = true;
      }
    } catch (e) {
      print('err ${e}');
    }
  }

filterData(bool? jenis) async {
  status.value = false;
  var pd;

  Query query = fs.collection('produk');

  if (jenis != null) {
    query = query.where('status', isEqualTo: jenis);
  }

  pd = await query.get();

  if (pd.docs.isNotEmpty) {
    data = [];
    pd.docs.forEach((e) {
      Produk produkList = Produk.fromJson(Map.from(e.data()), e.id);
      data.add(produkList);
    });
    status.value = true;
  }
}


  delete(String id) async{
    try {
      status.value = false;
      await fs.collection('produk').doc(id).delete();
      data = [];
      await getProduct();
      status.value = true;
      Get.showSnackbar(GetSnackBar(
        title: 'Berhasil',
        message: 'Berhasil Menghapus',
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      Get.defaultDialog(middleText: 'gagal');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }
}
