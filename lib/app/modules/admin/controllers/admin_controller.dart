// ignore_for_file: avoid_print

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
      final produk = await fs.collection("produk").get();

      print(produk);

      if (produk.docs.isNotEmpty) {
        produk.docs.map((e) {
          print(e.id);
          print(e.data());
          Produk productList = Produk.fromJson(Map.from(e.data()), e.id);
          data.add(productList);
        }).toList();
        status.value = true;
      }
    } catch (e) {
      print('err ${e}');
    }
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }
}
