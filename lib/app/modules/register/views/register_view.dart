// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';
import 'package:uas_flutter/color/color.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PENDAFTARAN PESERTA',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.lightBlue[50],
                child: Text(
                  'Silakan lengkapi form pendaftaran berikut. Akun pengguna yang didaftarkan harus atas nama perorangan, apabila Anda akan bertindak sebagai kuasa dari perusahaan/badan hukum, akan ada pilihan dan isian tambahan pada saat mengikuti lelang.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.konfPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Konfirmasi Password',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    if (!auth.loading.value) {
                      if (controller.email.text.isNotEmpty &&
                          controller.password.text.isNotEmpty &&
                          controller.konfPassword.text.isNotEmpty) {
                        if (controller.konfPassword.text ==
                            controller.password.text) {
                          controller.loading.value = true;
                          await auth.register(
                              controller.email.text, controller.password.text);
                          controller.loading.value = false;
                        } else {
                          Get.defaultDialog(
                              title: 'Password dan Konfirmasi Password Beda!',
                              middleText:
                                  'Samakan Password dan Konfirmasi Password');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: CustomColors.ijoTua,
                  ),
                  child: Obx(
                    () => Text(
                        auth.loading.value == true ? 'Loading...' : 'Daftar',
                        style: TextStyle(color: CustomColors.kremMuda)),
                  )),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => Get.offAllNamed(Routes.LOGIN),
                  child: Text(
                    'Sudah punya akun? Klik disini',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
