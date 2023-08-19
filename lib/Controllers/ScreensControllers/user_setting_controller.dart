import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserSettingsController extends GetxController {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final String email = FirebaseAuth.instance.currentUser!.email!;

  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? image;

  // save user data to firebase firestore
  void saveUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': nameController.text,
      'bio': bioController.text,
      'city': cityController.text,
      'phone': phoneController.text,
    }, SetOptions(merge: true)).then((value) => {Get.back()});
    Get.snackbar('تم', 'تم حفظ البيانات',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent[400]);
    update();
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      Get.back();
      update();
    } else {
      Get.snackbar('خطأ', 'لم يتم اختيار صورة',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent[400]);
    }
  }

  // get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      Get.back();
      update();
    } else {
      Get.snackbar('خطأ', 'لم يتم اختيار صورة',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent[400]);
    }
  }

  // get user data from firebase firestore
  void getUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      nameController.text = value.data()!['name'] ?? '';
      bioController.text = value.data()!['bio'] ?? '';
      cityController.text = value.data()!['city'] ?? '';
      phoneController.text = value.data()!['phone'] ?? '';
    });
  }



  // update user data in firebase firestore
  void updateUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': nameController.text,
      'bio': bioController.text,
      'city': cityController.text,
      'phone': phoneController.text,
    }, SetOptions(merge: true)).then((value) => {
          Get.snackbar('تم', 'تم تحديث البيانات',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.greenAccent[400])
        });
  }

  // save image to firebase storage
  void saveImage() async {
    if (image == null) {
      return;
    }
    await FirebaseStorage.instance
        .ref()
        .child('users/$uid')
        .putFile(image!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'image': value});
      });
    });
  }

  // get image from firebase storage
  void getImage() async {
    await FirebaseStorage.instance
        .ref()
        .child('users/$uid')
        .getDownloadURL()
        .then((value) {
      image = File(value);
      if (kDebugMode) {
        print(value);
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }).whenComplete(() {
      update();
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      if (kDebugMode) {
        print(
            "=========================timeout===============================");
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
    getImage();
  }
}
