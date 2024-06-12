// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';
import 'package:uas_flutter/color/color.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.person,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.email,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                labelText: 'Alamat email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              controller: controller.password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'Masukkan password anda',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.offAllNamed(Routes.REGISTER),
                  child: Text(
                    'Daftar Disini',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  if (!auth.loading.value) {
                    auth.login(controller.email.text, controller.password.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: CustomColors.ijoTua,
                    elevation: 0),
                child: Obx(
                  () => Text(
                    auth.loading.value ? 'Loading...' : 'Sign In',
                    style:
                        TextStyle(fontSize: 18, color: CustomColors.kremMuda),
                  ),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => auth.signInWithGoogle(),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: CustomColors.kremMuda,
                  elevation: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Sign In With Google',
                    style: TextStyle(fontSize: 18, color: CustomColors.ijoTua),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
