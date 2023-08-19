import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/ScreensControllers/auth_controller.dart';
import '../Constants/style.dart';
import '../Screens/SettingScreen/user_setting_screen.dart';
import 'image_profile_widget.dart';

// ignore: must_be_immutable
class UserProfileWidget extends StatelessWidget {
  final image;
  String name;

  UserProfileWidget({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
        child: Container(
          height: Get.height * 0.36,
          width: Get.width,
          decoration: colorDecoration,
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.08, left: 10),
            child: ImageWidget(
              image: image,
              name: name,
            ),
          ),
        ),
      ),
      Positioned(
        top: Get.height * 0.04,
        left: Get.width * 0.88,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "تسجيل الخروج",
                  middleText: "هل تريد تسجيل الخروج من التطبيق؟",
                  textConfirm: "نعم",
                  textCancel: "لا",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.black,
                  onConfirm: () {
                    authController.signOut();
                  },
                );
              },
              icon:
                  const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
      Positioned(
        top: Get.height * 0.04,
        right: Get.width * 0.88,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(UserSettingsScreen.routeName);
              },
              icon: const Icon(Icons.settings, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    ]);
  }
}
