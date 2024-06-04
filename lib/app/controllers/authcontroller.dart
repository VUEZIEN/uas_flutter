// ignore_for_file: avoid_print, unused_local_variable, unnecessary_overrides, unused_element, prefer_const_constructors, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';

class AuthController extends GetxController {
  String codeOtp = "";

  Stream authStatus = FirebaseAuth.instance.authStateChanges();

  login(String email, String password,) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.back();

      List<String> adminEmails = [
        'akunikky11@gmail.com',
        'admin@gmail.com',
        'daffazikrillah1@gmail.com'
      ];
      if (adminEmails.contains(email)) {
        Get.offAllNamed(Routes.ADMIN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
       Get.defaultDialog(middleText: "Gagal Login", title: "Error");
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  register(String email, String password) async {
    try {
      Get.defaultDialog(content: CircularProgressIndicator(), title: "loading");
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      try {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.defaultDialog(middleText: "Gagal Login Google", title: "Error");
      }
    }
  }
}
