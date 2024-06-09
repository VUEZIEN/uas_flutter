// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ruang_lelang_controller.dart';

class RuangLelangView extends GetView<RuangLelangController> {
 final data = Get.arguments as String;

 @override
  Widget build(BuildContext context) {
    print('${data}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('RuangLelangView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(
          'RuangLelangView is working ${data}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
