import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Constants/fonts.dart';

class SnakBar {
  // success snak bar
  static void successSnakBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: titleTextStylew,
          textAlign: TextAlign.right,
        ),
        messageText: Text(
          message,
          style: subtitleTextStylew,
          textAlign: TextAlign.right,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent[400]);
  }

  // error snak bar
  static void errorSnakBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: titleTextStylew,
          textAlign: TextAlign.right,
        ),
        messageText: Text(
          message,
          style: subtitleTextStylew,
          textAlign: TextAlign.right,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent[400]);
  }

  // warning snak bar
  static void warningSnakBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: titleTextStyle,
          textAlign: TextAlign.right,
        ),
        messageText: Text(
          message,
          style: subtitleTextStyle,
          textAlign: TextAlign.right,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.yellowAccent[400]);
  }
}
