// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/home_controller.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.SCAN);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: CustomColors.ijoTua,
                elevation: 0),
            child: Text(
              'IKUT LELANG',
              style: TextStyle(fontSize: 18, color: CustomColors.kremMuda),
            ),
          ),
          Center(
            child: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Apakah anda yakin?',
                    middleText: 'Sign Out dari lelang online?',
                    confirm: ElevatedButton(
                        onPressed: () => auth.logout(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.ijoTua),
                        child: Text(
                          'Ya!',
                          style: TextStyle(color: Colors.white),
                        )),
                    cancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.kremTua),
                        onPressed: () => Get.back(),
                        child: Text('Tidak!',
                            style: TextStyle(color: Colors.white))),
                  );
                },
                icon: Icon(Icons.logout)),
          ),
        ],
      ),
    );
  }
}
