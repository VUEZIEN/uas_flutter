// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';

class AdminController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = false.obs;
  List<Produk> data = [];
  getProduct() async {
    final produk = await fs.collection("produk").get();

    if (produk.docs.isNotEmpty) {
      print(produk.docs);
      produk.docs.map((e) {
        print(e.data());
        print(e.id);
        Produk productList = Produk.fromJson(Map.from(e.data()), e.id);
        data.add(productList);
      }).toList();
      status.value = true;
    }
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }
}
