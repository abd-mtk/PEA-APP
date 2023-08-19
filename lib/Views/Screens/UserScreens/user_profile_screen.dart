import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/ScreensControllers/user_setting_controller.dart';
import '../../Widgets/section_profile.dart';
import '../../Widgets/user_profile_widget.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  static const String routeName = '/userProfileScreen';
  UserSettingsController controller = Get.put(UserSettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<UserSettingsController>(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UserProfileWidget(
                image: controller.image,
                name: controller.nameController.text,
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
              SectionProfile(
                title: "البريد الالكتروني",
                subtitle: controller.email,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
