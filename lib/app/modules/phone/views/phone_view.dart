import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/phone_controller.dart';

class PhoneView extends GetView<PhoneController> {
  const PhoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PhoneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
