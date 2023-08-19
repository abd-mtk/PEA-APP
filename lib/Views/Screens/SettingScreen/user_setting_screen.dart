import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Constants/colors.dart';

import '../../../Controllers/ScreensControllers/user_setting_controller.dart';
import '../../Widgets/image_profile_widget.dart';
import '../../Widgets/input_field.dart';

// ignore: must_be_immutable
class UserSettingsScreen extends StatelessWidget {
  UserSettingsScreen({super.key});
  static const String routeName = '/userSettingsScreen';
  UserSettingsController controller = Get.put(UserSettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeColor,
        title: const Text("User Settings"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'تأكيد',
                middleText: 'هل تريد حفظ التغييرات؟',
                textConfirm: 'نعم',
                textCancel: 'لا',
                confirmTextColor: Colors.white,
                buttonColor: Colors.black,
                onConfirm: () {
                  controller.saveUserData();
                  controller.saveImage();
                },
                onCancel: () {
                  Get.back();
                },
              );
            },
            icon: const Icon(Icons.save, color: Colors.white, size: 25),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<UserSettingsController>(
                      builder: (_) => ImageWidget(
                        image: controller.image,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 230,
                  top: 120,
                  child: IconButton(
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
                              color: Colors.blueAccent,
                              iconSize: 35,
                              onPressed: () {
                                controller.getImageFromCamera();
                              },
                            ),
                          ),
                          cancel: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: IconButton(
                              icon: const Icon(Icons.photo,
                                  color: Colors.blueAccent),
                              iconSize: 35,
                              onPressed: () {
                                controller.getImageFromGallery();
                              },
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.change_circle_outlined,
                          color: Colors.blueAccent[400], size: 35)),
                ),
              ],
            ),
            InputField(
              defultValue: controller.nameController.text,
              hintText: 'الاسم',
              prefixicon: Icons.person,
              suffixicon: null,
              inputController: controller.nameController,
              showPassword: false,
              maxchar: 20,
            ),
            InputField(
              defultValue: controller.bioController.text,
              hintText: 'الوصف',
              prefixicon: Icons.info,
              suffixicon: null,
              inputController: controller.bioController,
              showPassword: false,
              maxchar: 100,
            ),
            InputField(
              defultValue: controller.cityController.text,
              hintText: 'منطقة السكن',
              prefixicon: Icons.location_city,
              suffixicon: null,
              inputController: controller.cityController,
              showPassword: false,
              maxchar: 50,
            ),
            InputField(
              defultValue: controller.phoneController.text,
              hintText: 'رقم الهاتف',
              prefixicon: Icons.phone,
              suffixicon: null,
              inputController: controller.phoneController,
              showPassword: false,
              maxchar: 15,
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
