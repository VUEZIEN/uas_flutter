// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/detail_lelang_controller.dart';

class DetailLelangView extends GetView<DetailLelangController> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Lelang', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'DetailLelangView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
