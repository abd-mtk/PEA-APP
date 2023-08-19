import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DisplayUserPorfileController extends GetxController {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  String imageUrl = '';

  // get user data by id from firebase firestore
  Future getUserDataById(String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      // print(value.data());
      nameController.text = value.data()!['name'] ?? '';
      bioController.text = value.data()!['bio'] ?? '';
      cityController.text = value.data()!['city'] ?? '';
      phoneController.text = value.data()!['phone'] ?? '';
      imageUrl = value.data()!['image'] ?? '';
      update();
    });
    update();
  }

  @override
  void onInit() {
    getUserDataById(Get.arguments);
    super.onInit();
  }
}
