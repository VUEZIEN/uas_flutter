// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/data/admin_emails.dart';
import 'package:uas_flutter/firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStatus,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: "Application",
            initialRoute: snapshot.data != null
                ? (snapshot.data.email == 'ariiqmaazin@gmail.com' ? Routes.ADMIN : Routes.HOME)
                : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
