import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pea/Controllers/ScreensControllers/create_event_controller.dart';

import '../Constants/button_style.dart';
import '../Constants/fonts.dart';
import '../Constants/style.dart';

// ignore: must_be_immutable
class ImagePicker extends StatelessWidget {
  CreateEventController controller;
  ImagePicker({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SnowButton(
            text: const Text('حذف', style: buttonTextStylec),
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            decoration: snowContainer,
            height: 40,
            color: Colors.white,
            onPressed: () {
              controller.image = null;
              controller.update();
            },
          ),
          SnowButton(
            text: const Text('ارفاق صورة', style: buttonTextStylec),
            icon: const Icon(Icons.photo_camera_back_outlined,
                color: Colors.teal),
            decoration: snowContainer,
            height: 40,
            color: Colors.white,
            onPressed: () {
              Get.defaultDialog(
                title: "اختيار صورة",
                middleText: "من اين تريد اختيار الصورة؟",
                textConfirm: "الكاميرا",
                textCancel: "الاستوديو",
                confirm: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    color: Colors.black,
                    iconSize: 45,
                    onPressed: () {
                      controller.getImageFromCamera();
                      Get.back();
                    },
                  ),
                ),
                cancel: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                    icon: const Icon(Icons.photo, color: Colors.teal),
                    iconSize: 45,
                    onPressed: () {
                      controller.getImageFromGallery();
                      Get.back();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
