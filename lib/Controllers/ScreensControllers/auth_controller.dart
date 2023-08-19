import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = true;
  bool showConfirmPassword = true;
  void togglePassword() {
    showPassword = !showPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  void saveUserData() async {
    prefs!.setString('email', emailController.text);
    prefs!.setString('password', passwordController.text);
    prefs!.setString('uid', FirebaseAuth.instance.currentUser!.uid);
  }

  // save user data to firebase firestore
  void saveUserDataFirbase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'email': emailController.text,
      'password': passwordController.text,
    });
  }

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        saveUserData();
        saveUserDataFirbase();
        Get.offAllNamed('/homeScreen');
      } else {
        Get.snackbar('خطأ في البريد الالكتروني', 'البريد الالكتروني غير مفعل');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('خطأ في البريد الالكتروني', 'البريد الالكتروني غير مسجل');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('خطأ في كلمة المرور', 'كلمة المرور غير صحيحة');
      }
    }
  }

  // sign up using email and password  and verify email by sending email verification
  void register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('خطأ في كلمة المرور', 'كلمة المرور غير متطابقة');
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        FirebaseAuth.instance.currentUser?.sendEmailVerification();
        Get.snackbar('تم التسجيل', 'تم ارسال رسالة الى البريد الالكتروني');
        Get.offAllNamed('/loginScreen');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('خطأ في كلمة المرور', 'كلمة المرور ضعيفة');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('خطأ في البريد الالكتروني', 'البريد الالكتروني مسجل');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // TODO: reset password using email

  // sign out
  void signOut() async {
    await FirebaseAuth.instance.signOut();
    prefs!.clear();
    Get.offAllNamed('/loginScreen');
  }
}
