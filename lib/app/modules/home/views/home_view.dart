// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/color/color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
    final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
      ),
      body:  Column(
        children: [
          Text("user view"),
          Center(
                child: IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Apakah anda yakin?',
                        middleText: 'Sign Out dari lelang online?',
                        confirm: ElevatedButton(
                            onPressed: () => auth.logout(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.ijoTua
                            ),
                            child: Text(
                              'Ya!',
                              style: TextStyle(color: Colors.white),
                            )),
                        cancel: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.kremTua),
                            onPressed: () => Get.back(),
                            child: Text('Tidak!', style: TextStyle(color: Colors.white))),
                      );
                    },
                    icon: Icon(Icons.logout)),
              ),
        ],
      ),
    );
  }
}
