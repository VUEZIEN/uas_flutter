import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("user view"),
          Center(
                child: IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Are u sure',
                        middleText: 'logout this apk?',
                        confirm: ElevatedButton(
                            onPressed: () => auth.logout(),
                            child: Text(
                              'yess',
                              style: TextStyle(color: Colors.white),
                            )),
                        cancel: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () => Get.back(),
                            child: Text('no')),
                      );
                    },
                    icon: Icon(Icons.logout)),
              ),
        ],
      ),
    );
  }
}
