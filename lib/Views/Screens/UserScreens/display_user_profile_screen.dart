import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/ScreensControllers/display_user_data_controller.dart';
import '../../Widgets/section_profile.dart';

// ignore: must_be_immutable
class DisplayUserProfileScreen extends StatelessWidget {
  DisplayUserProfileScreen({super.key});
  static const String routeName = '/displayUserProfileScreen';
  DisplayUserPorfileController controller =
      Get.put(DisplayUserPorfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayUserPorfileController>(builder: (_) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: Get.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.imageUrl != ""
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              controller.imageUrl,
                            ),
                            radius: 80,
                          )
                        : Image.asset("assets/images/unknown.png",
                            width: Get.width * 0.4,
                            height: Get.height * 0.2,
                            fit: BoxFit.scaleDown),
                    const Gap(10),
                    Text(
                      controller.nameController.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            SectionProfile(
              title: "اسم المستخدم",
              subtitle: controller.nameController.text,
            ),
            SectionProfile(
              title: "الوصف",
              subtitle: controller.bioController.text,
              maxLines: 4,
            ),
            SectionProfile(
              title: "تواصل معي عبر رقم الهاتف",
              subtitle: controller.phoneController.text,
            ),
            SectionProfile(
              title: "العنوان",
              subtitle: controller.cityController.text,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    });
  }
}
