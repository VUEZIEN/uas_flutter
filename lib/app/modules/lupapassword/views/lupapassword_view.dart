import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lupapassword_controller.dart';

class LupapasswordView extends GetView<LupapasswordController> {
  const LupapasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LupapasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LupapasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
