import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Constants/button_style.dart';
import 'package:pea/Views/Constants/fonts.dart';
import 'package:pea/Views/Screens/MapsScreens/get_location_map_screen.dart';
import 'package:pea/imports.dart';

import '../../../Controllers/ScreensControllers/create_event_controller.dart';
import '../../Constants/colors.dart';
import '../../Constants/style.dart';
import '../../Widgets/image_picker.dart';
import '../../Widgets/image_profile_widget.dart';
import '../../Widgets/input_field.dart';
import '../../Widgets/section_profile.dart';
import '../../Widgets/time_widget.dart';

// ignore: must_be_immutable
class CreateEventsScreen extends StatelessWidget {
  CreateEventsScreen({super.key});
  static const String routeName = '/createEventsScreen';
  CreateEventController controller =
      Get.put(CreateEventController(), permanent: true);
  var info = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeColor,
        title: const Text("انشاء حدث جديد"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(HomeScreen.routeName);
          },
          icon: const Icon(Icons.close, color: Colors.white, size: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'تأكيد',
                middleText: 'هل تريد نشر الحدث',
                textConfirm: 'نعم',
                textCancel: 'لا',
                confirmTextColor: Colors.white,
                buttonColor: Colors.teal,
                onConfirm: () {
                  controller.addEvent(info);
                  info = null;
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
            Column(
              children: [
                GetBuilder<CreateEventController>(
                  builder: (_) => ImageWidget(
                    isPost: true,
                    image: controller.image,
                    textStyle: subtitleTextStyle,
                  ),
                ),
                ImagePicker(controller: controller),
              ],
            ),
            InputField(
              defultValue: controller.titleController.text,
              hintText: 'اكتب عنوان الحدث',
              prefixicon: Icons.title,
              suffixicon: null,
              inputController: controller.titleController,
              showPassword: false,
              maxchar: 30,
            ),
            InputField(
              defultValue: controller.descriptionController.text,
              hintText: 'الوصف',
              inputController: controller.descriptionController,
              showPassword: false,
              maxchar: 250,
              maxLines: 7,
            ),
            const Gap(2),
            SectionProfile(
              title: "قم بتعيين تاريخ انتهاء الحدث",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SnowButton(
                      text:
                          const Text('تحديد التاريخ', style: buttonTextStylec),
                      icon: const Icon(Icons.edit_calendar_outlined,
                          color: Colors.redAccent),
                      decoration: snowContainer,
                      height: 40,
                      color: Colors.white,
                      onPressed: () async {
                        controller.timePicker();
                      },
                    ),
                    GetBuilder<CreateEventController>(builder: (_) {
                      return TimeWidget(time: controller.endDate);
                    }),
                  ],
                ),
              ),
            ),
            const Gap(5),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "قم بتحديد موقع الحدث",
                    style: hintStyle,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SnowButton(
                  text: const Text('موقعي الحالي', style: buttonTextStylec),
                  icon: const Icon(Icons.location_on_rounded,
                      color: Colors.redAccent),
                  decoration: snowContainer,
                  height: 40,
                  color: Colors.white,
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'تأكيد',
                      middleText: 'هل تريد تحديد موقعك الحالي',
                      textConfirm: 'نعم',
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.teal,
                      onConfirm: () async {
                        controller.myLocation(true);
                        Get.back();
                      },
                    );
                  },
                ),
                SnowButton(
                  text: const Text('الخرائط', style: buttonTextStylec),
                  icon: const Icon(Icons.map_outlined, color: Colors.green),
                  decoration: snowContainer,
                  height: 40,
                  color: Colors.white,
                  onPressed: () {
                    Get.toNamed(GetLocationScreen.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
